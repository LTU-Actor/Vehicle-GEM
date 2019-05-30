while true do
  local sign = last_UInt8("/stop_sign/stop_sign");
  local sign_size = last_UInt32("/stop_sign/sign_size");

  if sign > 0 then
    send(1.0, 0.0);
    spin_for(3000);
    estop();
  end

  send(1.0, 0.00);
  heartbeat();
  spin_for(100);
end
