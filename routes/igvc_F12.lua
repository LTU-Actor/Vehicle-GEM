require('igvc')

last_bool("/pothole/out")

send_topic("/blob/cmd")
while true do
  spin_for(10)
  if last_bool("/pothole/out") then
    go_dist(5, 1.5, 0.15)
    go_dist(1.5, 1.5, 0.0)
    go_dist(5, 1.5, -0.15)
    break
  end
end

topic_dist(25, "/blob/cmd")


