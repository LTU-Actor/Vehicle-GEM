require('igvc')

while dist(waypoints.parking.lat, waypoints.parking.lon) > 11 do
  pub_latlong(waypoints.parking.lat, waypoints.parking.lon, "/waypoint/waypoint")
  send_topic("/waypoint/cmd")
  info_distance(dist(waypoints.parking.lat, waypoints.parking.lon))
  spin_for(10)
end

last_twist("/blob_park/cmd")

send(0.0, 0.0)
spin_for(3000)
backout_left()
send(0.0, 0.0)
spin_for(3000)
topic_dist(6.4, "/blob_park/cmd")