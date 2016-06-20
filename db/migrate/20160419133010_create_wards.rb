class CreateWards < ActiveRecord::Migration
  def change
    create_table :wards do |t|
      t.string :name
      t.integer :ward_no, null: false
      t.string :mun_ref
      t.integer :area_id
      t.timestamps null: false
    end
  end
end
