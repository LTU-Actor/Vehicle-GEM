function wait_estop()
  last_bool("/estop/state")
  spin_for(300)
  while last_bool("/estop/state") do spin_for(100) end 
end

set_speed_mux(1.0)
set_turn_mux(0.3)

while true do
  heartbeat()
  spin_for(5)

  wait_estop()
  send(1.5, 0)
  spin_for(3000)
;
  send_topic('/blob_sunny/cmd')
  spin_for(6000)
  send(1.5, 0)
  spin_for(1500)
  send(0, 0)

  estop()
end

