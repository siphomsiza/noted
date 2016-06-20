class CreateSubdepartments < ActiveRecord::Migration
  def change
    create_table :subdepartments, force: :cascade do |t|
      t.string :subdepartment_name, null: false
      t.integer :department_id, foreign_key: true
      
		t.timestamps null: false
    end
  end
end
