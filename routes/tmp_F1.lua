stop_complete = false

while true and not stop_complete do
  -- Get stop sign status and distance to stop sign
  local sign = last_uint8("/stop_sign_detection/stop_sign");
  local dist = last_float64("/region/left_closest");

  -- Display information on the GUI
  info_distance(dist)
  info_index(sign)

  -- Begin lane following
  -- send_topic("/blob_cloudy/cmd")
  send(1.0,0.0)

  -- Check for sign
  if sign > 0 then
    -- Sign found, slow down and stop when close to sign
    send(0.50, 0.0);
    while dist > 2 or dist < 0 do
      heartbeat()
      dist = last_float64("/region/left_closest");
      info_distance(dist)
      spin_for(10);
    end
    send(0.0,0.0);
    spin_for(5000);
    stop_complete = true
  end

  heartbeat();
  spin_for(50);
end

send(1.0,0.0);
spin_for(7000);

stop_at_object = false
while not stop_at_object do

  -- Get distance to barrels
  local dist = last_float64("/region/front_closest");

  -- Display information on the GUI
  info_distance(dist)

  send(0.50, 0.0);
  while dist > 2 or dist < 0 do
    heartbeat()
    dist = last_float64("/region/front_closest");
    info_distance(dist)
    spin_for(10);
  end

  send(0.0,0.0);
  spin_for(5000);
  stop_at_object = true
end

 
--send(2.00,0.0);
--spin_for(5000);
estop();

