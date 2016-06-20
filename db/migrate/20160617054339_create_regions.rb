class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name, :null => false, :unique => true
      t.integer :master_setup_id, :null => false
      t.timestamps null: false
    end
  end
end
