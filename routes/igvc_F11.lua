require('igvc')

send_topic("/blob/cmd")
while last_float64("/region/front_closest") < 0 or last_float64("/region/front_closest") > 8.3 do
  spin_for(10)
end

go_dist(4, 1.3, 2.7)
go_dist(2, 1.5, 0.0)

send_topic("/blob/cmd")
while last_float64("/region/front_closest") < 0 or last_float64("/region/front_closest") > 8.6 do
  spin_for(10)
end

go_dist(2, 1.5, -0.7)
go_dist(4, 1.3, 2.7)

topic_dist(25, "/blob/cmd")