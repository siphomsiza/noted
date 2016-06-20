class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments, force: :cascade do |t|
      t.string :name, null: false, unique: true, index: true
      t.string :tel_no, null: false
      t.string :fax_no, null: false
      t.integer :user_id, foreign_key: true

      t.timestamps null: false
      
    end
  end
end
