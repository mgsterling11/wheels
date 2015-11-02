class HistoricalTrips < ActiveRecord::Migration
  def change
    create_table :historicaltrips do |t|
      t.decimal :Pickup_longitude
      t.decimal :Pickup_latitude
      t.decimal :Dropoff_longitude
      t.decimal :Dropoff_latitude
      t.decimal :Tip_amount
      t.decimal :Total_amount
      t.datetime :pickup_datetime
      t.datetime :dropoff_datetime
    end
  end
end
