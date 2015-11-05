class CreateHistoricalTrips < ActiveRecord::Migration
  def change
    create_table :historical_trips do |t|
      t.decimal :pickup_longitude
      t.decimal :pickup_latitude
      t.decimal :dropoff_longitude
      t.decimal :dropoff_latitude
      t.decimal :tip_amount
      t.decimal :total_amount
      t.integer :passenger_count
      t.float :trip_distance
      t.datetime :tpep_pickup_datetime
      t.datetime :tpep_dropoff_datetime
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
