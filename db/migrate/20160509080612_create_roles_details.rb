class CreateRolesDetails < ActiveRecord::Migration
  def change
    create_table :roles_details do |t|
      t.integer :role_id, null: false, foreign_key: true
      t.integer :subdepartment_id, null: false,  foreign_key: true
      t.integer :department_id, null: false,  foreign_key: true
      t.timestamps null: false
    end
  end
end
