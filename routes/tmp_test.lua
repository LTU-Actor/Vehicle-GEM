while true do
  -- Get distance to object
  local dist = last_float64("/region/front_closest")

  -- Display information on the GUI
  info_distance(dist)
  heartbeat()
  spin_for(10)
end
