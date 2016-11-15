class CreateMasterSetups < ActiveRecord::Migration
  def change
    create_table :master_setups, force: :cascade do |t|
      t.string :municipality, :null => false
      t.string  :province, null: false
      t.float :latitude
      t.float  :longitude
      t.text   :address
      t.timestamps null: false
    end
  end
end
