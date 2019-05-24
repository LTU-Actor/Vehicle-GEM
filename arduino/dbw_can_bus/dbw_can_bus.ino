#include <Arduino.h>
#include <SPI.h>
#include "mcp_can.h"

const int SPI_CS_PIN = 10;

long unsigned int rxId;
unsigned char len = 0;
unsigned char buf[8];
bool var_updated = false;
bool auton = false;

enum gear_pos { NONE=0, FORWARD = 1, NEUTRAL = 2, REVERSE = 3 };

bool autonomous = false;
bool canInit = false;
int gear = FORWARD;
int sim_gear = FORWARD;

//Pins attaching to the switch (First Purple, Second Yellow)
int input_pin_1 = 6;
int input_pin_2 = 7;

//Pins coming out of arduino foing to 
int output_pin_1 = 4;
int output_pin_2 = 5;

MCP_CAN CAN(SPI_CS_PIN); 

void setup() {
  Serial.begin(115200);

  pinMode(input_pin_1, INPUT_PULLUP);
  pinMode(input_pin_2, INPUT_PULLUP);
  pinMode(output_pin_1, OUTPUT);
  pinMode(output_pin_2, OUTPUT);

  int max_retry = 8;
  int retrys = 0;
  while (CAN_OK != CAN.begin(CAN_500KBPS) || retrys < max_retry)
  {
      Serial.println("CAN BUS Module Failed to Initialized");
      Serial.println("Retrying....");
      delay(200);
      retrys++;
  }   

  if(retrys < max_retry){
    canInit = true;
  }
  
  Serial.println("CAN BUS Module Initialized!");
}

void loop() {

  if(!canInit){
    if(CAN_OK == CAN.begin(CAN_500KBPS)){
      canInit = true;
    }
  }
  
  //Check if CAN Bus Receives a command from 0x066
  if(canInit && CAN_MSGAVAIL == CAN.checkReceive())
  {
    CAN.readMsgBuf(&len, buf);
    rxId = CAN.getCanId();

    if(rxId == 0x066 && (int)len > 1){
      int gearChange = buf[0];
      if (buf[1] == 0) auton = false;
      else if (buf[2] == 1) auton = true;
      bool enabled = buf[2] ? true : false;
      if(!enabled) auton = false;
      if(sim_gear != gearChange || auton != autonomous){
         changeSimulatedGear(gearChange, auton);
      }
    }
  }

  //Checks if physical switch changed
  handleSwitchStates();
}

void digitalWriteHelper(int pin, int mode)
{
  if (mode == HIGH)
  {
    pinMode(pin, INPUT);
  } 
  else 
  {
    pinMode(pin, OUTPUT);
    pin = LOW;
  }
}

void handleSwitchStates(){
  int pin1 = digitalRead(input_pin_1);
  int pin2 = digitalRead(input_pin_2);
  bool fault1 = false;
  bool fault2 = false;

  if(autonomous){
    if(sim_gear == FORWARD){
      digitalWriteHelper(output_pin_1, LOW);
      digitalWriteHelper(output_pin_2, HIGH);
    }
    else if(sim_gear == NEUTRAL){
      digitalWriteHelper(output_pin_1, HIGH);
      digitalWriteHelper(output_pin_2, HIGH);
    }
    else if(sim_gear == REVERSE){
      digitalWriteHelper(output_pin_1, HIGH);
      digitalWriteHelper(output_pin_2, LOW);
    }
    else{
      fault1 = true;
    }
  }
  else{
     digitalWriteHelper(output_pin_1, pin1);
     digitalWriteHelper(output_pin_2, pin2);
  }

  if(pin1 == LOW && pin2 == HIGH){ //0v, 5v
    gear = FORWARD;
  }
  else if(pin1 == HIGH && pin2 == HIGH){ //5v, 5v
    gear = NEUTRAL;
  }
  else if(pin1 == HIGH && pin2 == LOW){ //5v, 0v
    gear = REVERSE;
  }
  else{
    fault2 = true;
  }

  if(var_updated){ sendReport(true, fault1, fault2); }
  var_updated = false;
}

void changeSimulatedGear(int gearChange, int auton){
  
  if(gearChange != NONE){
      sim_gear = gearChange;
  }

  autonomous = auton;
  var_updated = true;
}

void sendReport(bool success, bool fault1, bool fault2){

  unsigned int txID = 0x067; // This format is typical of a 29 bit identifier.. the most significant digit is never greater than one.
  unsigned char byteArr[8] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
  byteArr[0] = (unsigned char)gear;
  byteArr[1] = (unsigned char)sim_gear;
  byteArr[2] += (unsigned char)((int)success);
  byteArr[2] += (unsigned char)((int)autonomous << 1);
  byteArr[2] += (unsigned char)((int)false << 2);
  byteArr[2] += (unsigned char)((int)false << 3);
  byteArr[2] += (unsigned char)((int)fault1 << 4);
  byteArr[2] += (unsigned char)((int)fault2 << 5);
  byteArr[2] += (unsigned char)((int)false << 6);
  byteArr[2] += (unsigned char)((int)false << 7);
  
  CAN.sendMsgBuf(txID, 1, 8, byteArr); 
}
