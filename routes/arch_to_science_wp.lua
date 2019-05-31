wps = {
  {lat=42.474577731988404, lon=-83.24978459935954}, -- after long
  {lat=42.474443020559235, lon=-83.24961630603279}, -- 3 shield
  {lat=42.4743747342588,   lon=-83.24948869708074}, -- rusty stick
  {lat=42.47435906661956,  lon=-83.24932813838758}, -- sidewalk
  {lat=42.4743974394603,   lon=-83.24915945160514}, -- tree 5
  {lat=42.47448536517313,  lon=-83.24899809469223}, -- tree 2
  {lat=42.47457155453122,  lon=-83.24888768798787}, -- exit curve
  {lat=42.47462683972605,  lon=-83.24875816602247}, -- charles tree
  {lat=42.474935949391856, lon=-83.24834024117531}  -- fire hydrant
}

local wp = 1

send_topic("/waypoint/cmd")
while wps[wp] ~= nil do
  heartbeat()
  pub_latlong(wps[wp].lat, wps[wp].lon, "/waypoint/waypoint")
  local d = dist(wps[wp].lat, wps[wp].lon)
  pub_float32(d, "/dist")
  pub_int8(wp, "/wp")
  if d < 1.0 then wp = wp + 1 end
  spin_for(100)
end
