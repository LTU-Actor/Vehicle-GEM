require('igvc')

function stop_if_pedo()
  local d = last_int32("/region/left_far")
  info_index(d)
  if d > 5 then
   send(0.0, 0.0)
   return true
 end
end

send_topic("/blob/cmd")
while true do
  heartbeat()
  spin_for(5)
  if dist(waypoints.merge_start.lat, waypoints.merge_start.lon) < 2.5 then break end
end

while dist(waypoints.merge_start.lat, waypoints.merge_start.lon) < 3.3 do
  go_to_gps_i(waypoints.merge_end)
  spin_for(10)
end

topic_dist(15, "/blob/cmd")