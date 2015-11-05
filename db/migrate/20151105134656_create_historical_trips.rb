class CreateHistoricalTrips < ActiveRecord::Migration
  def change
    create_table :historical_trips do |t|
      t.float :pickup_longitude
      t.float :pickup_latitude
      t.float :dropoff_longitude
      t.float :dropoff_latitude
      t.float :tip_amount
      t.float :total_amount
      t.integer :passenger_count
      t.float :trip_distance
      t.datetime :tpep_pickup_datetime
      t.datetime :tpep_dropoff_datetime
      t.time :pickup_time 
      t.float :extra
      t.float :fare_amount
      t.float :mta_tax
      t.float :payment_type
      t.float :ratecodeid
      t.integer :vendorid
      t.float :tolls_amount
      t.string :store_and_fwd_flag
    end
  end
end
