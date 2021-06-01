require('igvc')

-- lane change left
--[[
send_topic("/blob/cmd")
while true do
  local d = last_float64("/region/front_closest")
  if d < 8 and d > 0 then
    go_dist(5, 1.5, 0.15)
    go_dist(2, 1.5, 0.0)
    go_dist(5, 1.5, -0.15)
    break
  end
  spin_for(10)
end
]]--

-- lane change right
send_topic("/blob/cmd")
while true do
  local d = last_float64("/region/front_closest")
  if d < 8 and d > 0 then
    go_dist(5, 1.5, -0.15)
    go_dist(2, 1.5, 0.0)
    go_dist(3.5, 1.5, 0.15)
    break
  end
  spin_for(10)
end

topic_dist(8, "/blob/cmd")