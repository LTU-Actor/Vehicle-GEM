require('igvc')

-- Go straight, stop, turn left
send_topic("/blob/cmd")
--send_topic("/waypoint/cmd")
--pub_latlong(waypoints.east.lat, waypoints.east.lon, "/waypoint/waypoint")
while true do
  heartbeat();
  spin_for(50);

  stop_if_lidar()

  local d = dist(waypoints.east.lat, waypoints.east.lon)
  info_distance(d)

  if look_for_sign() then
    turn_left()
    break
  end
end

-- follow the loop
send_topic("/blob/cmd")
while true do
  heartbeat()
  spin_for(5)

  stop_if_lidar()

  if look_for_sign() then
    turn_right()
    break
  end
end

-- let blob go for a little while
send_topic("/blob/cmd")
spin_for(3000)
