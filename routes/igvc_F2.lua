require('igvc')


send_topic("/blob/cmd")
while true do
  heartbeat()
  spin_for(5)

  stop_if_lidar()

  if look_for_sign() then
    turn_left()
    break
  end
end

send_topic("/blob/cmd")
while true do
  stop_if_lidar()
  spin_for(10)
end
