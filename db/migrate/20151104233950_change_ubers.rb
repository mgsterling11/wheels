class ChangeUbers < ActiveRecord::Migration
  def change
     drop_table :ubers
  end

  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
