class CreateWards < ActiveRecord::Migration
  def change
    create_table :wards, force: :cascade do |t|
      t.string :name, :unique=> true
      t.string :ward_no
      t.integer :area_id
      t.string :mun_ref
      t.timestamps null: false
    end
  end
end
