require('igvc')
--[[
while true do
  info_distance(dist(waypoints.parallel_park.lat, waypoints.parallel_park.lon))
  spin_for(10)
end
]]--
function go_to_gps_parallel(o)
  while dist(o.lat, o.lon) > 21.5 do
    go_to_gps_i(o)
    spin_for(10)
  end
end

go_to_gps_parallel(waypoints.parallel_park)

send(0.0, 0.0)
spin_for(3000)

--go_dist(2.9, -1.3, -0.5)
send(-1.3, -0.5)
spin_for(4500)

send(-1, -0.1)
spin_for(1000)

go_dist(2.37, -1.3, 2)
send(-1.3, 2)
spin_for(1400)

send(0.0, 0.0)
spin_for(3000)

send(1.0, 0.0)
spin_for(2000)