class ChangeUserTrips < ActiveRecord::Migration
  def change
    remove_column :user_trips, :Pickup_longitude, :string
    remove_column :user_trips, :Pickup_latitude, :string
    remove_column :user_trips, :Dropoff_longitude, :string
    remove_column :user_trips, :Dropoff_latitude, :string
    add_column :user_trips, :origin_id, :integer
    add_column :user_trips, :destination_id, :integer

    drop_table :locations

    create_table :origins do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
    end

    create_table :destinations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
    end
  end
end
