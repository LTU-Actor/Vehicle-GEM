wp_sign_lat =  42.4720933476
wp_sign_lon =  -83.2500988135

wp_cur_lat = wp_sign_lat
wp_cur_lon = wp_sign_lon

send(0.55, 0)

while true do
  local d = dist(wp_cur_lat, wp_cur_lon)
  if d < 1 then estop() end

  pub_latlong(wp_cur_lat, wp_cur_lon, "/waypoint/waypoint")
  pub_float32(d, "/dist")
  heartbeat()
  spin_for(50)
end

