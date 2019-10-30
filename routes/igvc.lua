waypoints = {
  east = {
    lat = 42.6679259957,
    lon = -83.2177477705
  },
  west = {
    lat = 42.6679248,
    lon = -83.2197374
  },
  parking = {
    lat = 42.6683136098,
    lon = -83.2196254914
  },
  merge_start = {
    lat = 42.6679019226,
    lon = -83.2187522138
  },
  merge_end = {
    lat = 42.6681018425,
    lon = -83.2185813241
  },
  pull_out_left = {
    lat = 42.6683307894,
    lon = -83.2187987059
  },
  parallel_park = {
    lat = 42.6683684177,
    lon = -83.2191257097
  }
}

-- initialize all subscribers
last_float64("/region/left_closest");
last_float64("/region/right_closest");
last_float64("/region/front_closest");

-- wait for their values to come in
spin_for(300)

lidar_stop_dist = 4.5

function wait_estop()
  last_bool("/estop/state")
  spin_for(300)
  while last_bool("/estop/state") do spin_for(100) end 
end

function stop_if_lidar()
  local d = last_float64("/region/front_closest")
  if d < lidar_stop_dist and d > 0 then estop() end
end

function look_for_sign()
  local sign = last_uint8("/stop_sign_detection/stop_sign")
  local sign_dist = last_float64("/region/right_closest")

  if sign > 0 then
    info_distance(sign_dist)
    send(0.55, 0.0);
    while sign_dist > 2 or sign_dist < 0 do
      sign_dist = last_float64("/region/right_closest")
      info_distance(sign_dist)
      spin_for(10);
    end
    send(0.0, 0.0)
    spin_for(6000)
    return true
  end
  return false
end

function go_dist(d, speed, a)
  local start_lat = _latitude
  local start_lon = _longitude
  send(speed, a)
  while dist(start_lat, start_lon) < d do
    info_distance(dist(start_lat, start_lon))
    stop_if_lidar()
    spin_for(10)
  end
end

function topic_dist(d, topic)
  local start_lat = _latitude
  local start_lon = _longitude
  send_topic(topic)
  while dist(start_lat, start_lon) < d do
    stop_if_lidar()
    spin_for(10)
  end
end

function turn_left()
  go_dist(12.5, 1.2, 0.14)
end

function turn_right()
  go_dist(3, 1, -0.1)
  go_dist(6, 1, -0.2)
end

function go_to_gps_i(o)  
  pub_latlong(o.lat, o.lon, "/waypoint/waypoint")
  send_topic("/waypoint/cmd")
  info_distance(dist(o.lat, o.lon))
  stop_if_lidar()
end

function go_to_gps(o)
  while dist(o.lat, o.lon) > 1.5 do
    go_to_gps_i(o)
    spin_for(10)
  end
end

function pullout_left()  go_dist(5, 1.5, 2)   end
function pullout_right() go_dist(5, 1.5, -2)  end
function backout_left()  go_dist(5, -1.5, 2)  end
function backout_right() go_dist(5, -1.5, -2) end
