require('igvc')

info_index(0)
info_index(0)
info_distance(0)

send_topic("/blob/cmd")
while true do
  spin_for(10)
  if look_for_sign() then
    turn_right()
    break
  end
end

-- first barrel
lidar_stop_dist = 4.0
send_topic("/blob/cmd")
while true do
  send_topic("/blob/cmd")
  local d = last_float64("/region/front_closest")
  if d < 7.5 and d > 0 then
    go_dist(5, 1.5, 0.15)
    go_dist(2, 1.5, 0.0)
    go_dist(5, 1.5, -0.15)
    break
  end
  spin_for(10)
end



-- barrel on corner change right
lidar_stop_dist = 3
send_topic("/blob/cmd")
while true do
  local d = last_float64("/region/front_closest")
  if d < 8.5 and d > 0 then
    go_dist(3.5, 1.5, -0.5)
    break
  end
  spin_for(10)
end
topic_dist(15, "/blob/cmd")
lidar_stop_dist = 5.5

-- stop for pedo
send_topic("/blob/cmd")
while true do
  info_index(1)
  stop_if_lidar()
  spin_for(10)
  if last_float64("/region/front_closest") < 10 and last_float64("/region/front_closest") > 0 then
    send(0.0, 0.0)
    break
  end
end

-- resume no pedo
send(0.0, 0.0)
while true do
  info_index(2)
  spin_for(10)
  if last_float64("/region/front_closest") < 0 then
    break
  end
end

send_topic("/blob/cmd")
while true do
  spin_for(10)
  if look_for_sign() then
    estop_dist = 3.9
    turn_left()
    break
  end
end

topic_dist(5, "/blob/cmd")