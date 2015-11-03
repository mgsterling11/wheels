class ChangeHistoricaltripsTitle < ActiveRecord::Migration
  def change
    drop_table :historicaltrips
  end
end
