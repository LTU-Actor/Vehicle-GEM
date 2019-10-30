require('igvc')
lidar_stop_dist=4.25
wps = {
  {lat=42.4747825186, lon=-83.2485436261, mux=1}, -- 1
  {lat=42.4747041191, lon=-83.2486583167, mux=2},   -- 2
  {lat=42.4746188926, lon=-83.2488209772, mux=1.3}, -- 3
  {lat=42.4745308164, lon=-83.2489418803, mux=1.3}, -- 4
  {lat=42.4744237835, lon=-83.2491163741, mux=1.3}, -- 5
  {lat=42.4743558203, lon=-83.2493925274, mux=1.3}, -- 6
  {lat=42.4743839362, lon=-83.2494532489, mux=1.3}, -- 7
  {lat=42.474400754, lon=-83.2495354665, mux=1.3},  -- 8
  {lat=42.4744525941, lon=-83.249608942, mux=1.3},  -- 9
  {lat=42.4746969895, lon=-83.2499413593, mux=2},   -- 10
  {lat=42.4748874996, lon=-83.2502039813, mux=1.0}, -- 11
  {lat=42.4750019568, lon=-83.2501487599, mux=0.8}, -- 12
  {lat=42.4749696013, lon=-83.2502105085, mux=-0.45},-- 13
  {lat=42.4749895684, lon=-83.2503404692, mux=-0.6},-- 14
  {lat=42.4749266316, lon=-83.2502654161, mux=1},   -- 15
  {lat=42.4745725058, lon=-83.2497990357, mux=2.5},   -- 16
  {lat=42.4744161999, lon=-83.2495953749, mux=1.7}, -- 17
  {lat=42.4743601399, lon=-83.2494778781, mux=1 },   -- 18
  {lat=42.4743594726, lon=-83.2492760923, mux=1},   -- 19
  {lat=42.4744384599, lon=-83.2490615658, mux=1},   -- 20
  {lat=42.4745609899, lon=-83.2488877377, mux=1.5}, -- 21
  {lat=42.4746991343, lon=-83.248673933, mux=1},    -- 22
  {lat=42.474830269, lon=-83.2484972362, mux=1},    -- 23
  {lat=42.4748031189, lon=-83.2483591726, mux=1},    -- 24
  {lat=42.4748220938, lon=-83.2483864552, mux=-0.7},    -- 25
  {lat=42.474967829, lon=-83.2483002169, mux=-0.7},    -- 26
}

local wp = 1
local last_mux = 1
local min_dist = 1000

send_topic("/waypoint/cmd")
while wps[wp] ~= nil do
  heartbeat()
  stop_if_lidar()

  local m = 1;
  if (wps[wp].mux ~= nil) then m = wps[wp].mux end
  if (m > 0 and last_mux < 0) or (m < 0 and last_mux > 0) then
    send(0.0, 0.0)
    spin_for(2000)
    if (m > 0) then set_turn_mux(1) else set_turn_mux(-1) end
    send_topic("/waypoint/cmd")
  end
  last_mux = m
  set_speed_mux(m) 

  pub_latlong(wps[wp].lat, wps[wp].lon, "/waypoint/waypoint")
  local d = dist(wps[wp].lat, wps[wp].lon)

  -- show on webpage
  info_distance(d)
  info_index(wp)

  if d < min_dist then min_dist = d end
  if d < 5.0 then
    if d > (min_dist + 0.2) then
      wp = wp + 1
      min_dist = 1000
    end
  end
  if wp == 27 then wp = 1 end
  spin_for(10)
end
