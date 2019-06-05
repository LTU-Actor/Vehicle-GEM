while true do
  local sign = last_uint8("/stop_sign_detection/stop_sign");
  local dist = last_float64("/region/left_closest");

  info_distance(dist)
  info_index(sign)

  send_topic("/blob_cloudy/cmd")

  if sign > 0 then
    send(0.55, 0.0);
    while dist > 2 or dist < 0 do
      heartbeat()
      dist = last_float64("/region/left_closest");
      info_distance(dist)
      spin_for(10);
    end
    estop();
  end

  heartbeat();
  spin_for(50);
end
