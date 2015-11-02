class UserTrips < ActiveRecord::Migration
  def change
    create_table :usertrips do |t|
      t.decimal :Pickup_longitude
      t.decimal :Pickup_latitude
      t.decimal :Dropoff_longitude
      t.decimal :Dropoff_latitude
      t.datetime :pickup_datetime
      t.integer :user_id
    end
  end
end
