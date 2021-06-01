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

  local l = last_int32("/region/left_far")
  local f = last_int32("/region/front_far")

  if l > 0 or f > 0 then
    send(0.0, 0.0)
  else
    send_topic("/blob/cmd")
  end
end
