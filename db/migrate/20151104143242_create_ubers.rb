class CreateUbers < ActiveRecord::Migration
  def change
    create_table :ubers do |t|

      t.timestamps null: false
    end
  end
end
