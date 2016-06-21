class CreateMasterSetups < ActiveRecord::Migration
  def change
    create_table :master_setups do |t|
      t.string :municipality, :null => false, :unique => true
      t.string  :province, null: false, :unique => true
      t.timestamps null: false
    end
  end
end
