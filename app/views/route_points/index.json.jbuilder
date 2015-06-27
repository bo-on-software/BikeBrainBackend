json.array!(@route_points) do |route_point|
  json.extract! route_point, :id, :trip_id, :gps_time, :gps_longitude, :gps_latitude, :gps_speed, :cadence
  json.url route_point_url(route_point, format: :json)
end
