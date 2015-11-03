class ChangeUsertripsTitle < ActiveRecord::Migration
  def change
    rename_table :usertrips, :user_trips
  end
end
