class CreateRoutePoints < ActiveRecord::Migration
  def change
    create_table :route_points do |t|
      t.references :trip, index: true, foreign_key: true
      t.timestamp :gps_time
      t.float :gps_longitude
      t.float :gps_latitude
      t.float :gps_speed
      t.float :cadence

      t.timestamps null: false
    end
  end
end
