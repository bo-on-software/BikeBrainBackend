json.extract! @trip, :id, :title, :created_at, :updated_at
json.array!(@points) do |point|
  json.extract! point, :id, :trip_id, :gps_time, :gps_longitude, :gps_latitude, :gps_speed, :cadence
end
