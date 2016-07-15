class CreateRolesDetails < ActiveRecord::Migration
  def change
    create_table :roles_details do |t|
      t.integer :role_id, null: false, foreign_key: true
      t.integer :subdepartment_id, null: false,  foreign_key: true
      t.integer :department_id, null: false,  foreign_key: true
      t.boolean :can_update, default: false
      t.boolean :can_edit, default: false
      t.boolean :can_create, default: false
      t.boolean :can_delete, default: false
      t.boolean :do_setup, default: false
      t.timestamps null: false
    end
  end
end
