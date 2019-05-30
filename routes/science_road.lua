while true do
  heartbeat();

  sign = last_UInt8("/stop_sign/stop_sign");
  sign_size = last_UInt32("/stop_sign/sign_size");

  if sign > 0 then
    send(1.5, 0.0);
    spin_for(3500);
    send(0.0, 0.0);
    spin_for(7000);

    send(1.5, 0.0);
    spin_for(11000);
    send(1.5, 14.0);
    spin_for(5000);
    send(1.5, 0.0);
    spin_for(500);
  end

  send_topic("/blob/cmd");
  spin_for(50);
end
