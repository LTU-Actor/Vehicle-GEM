require('igvc')

function stop_if_pedo()
  local d = last_float64("/region/front_closest")
  if d < 8.0 and d > 0 then
   send(0.0, 0.0)
   return true
 end
end

send_topic("/blob/cmd")
while true do
  heartbeat()
  spin_for(5)

  if stop_if_pedo() then
    break
  end
end
