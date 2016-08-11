class CreateMasterSetups < ActiveRecord::Migration
  def change
    create_table :master_setups do |t|
      t.string :municipality, :null => false
      t.binary  :logo,         null: false
      t.string  :province, null: false
      t.float :latitude
      t.float  :longitude
      t.timestamps null: false
    end
  end
end
