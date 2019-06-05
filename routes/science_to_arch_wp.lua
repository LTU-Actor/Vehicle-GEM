wps = {
  {lat=42.474677, lon=-83.248682}, 
  {lat=42.474617, lon=-83.248799},
  {lat=42.474511,   lon=-83.248960}, 
  {lat=42.474460,  lon=-83.249035}, 
  {lat=42.474404,   lon=-83.474404},
  {lat=42.474365,  lon=-83.249269}, 
  {lat=42.474367942282804,  lon=-83.24944785324087}, 
  {lat=42.474472,  lon=-83.249652},
  {lat=42.474858, lon=-83.250176},
  {lat=42.474884, lon=-83.250225},
  {lat=42.474921, lon=-83.250288}
}

local wp = 1

send_topic("/waypoint/cmd")
while wps[wp] ~= nil do
  heartbeat()
  pub_latlong(wps[wp].lat, wps[wp].lon, "/waypoint/waypoint")
  local d = dist(wps[wp].lat, wps[wp].lon)

  -- show on webpage
  info_distance(d)
  info_index(wp)

  if d < 1.0 then wp = wp + 1 end
  spin_for(100)
end
