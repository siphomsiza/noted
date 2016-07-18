class CreateDepartmentalAdministrators < ActiveRecord::Migration
  def change
    create_table :departmental_administrators do |t|
      t.integer :department_id, :null => false, foreign_key: true
      t.integer :user_id, :null => false, foreign_key: true
      t.boolean :can_create, default: false
      t.boolean :can_edit, default: false
      t.boolean :can_update, default: false
      t.boolean :can_approve, default: false

      t.timestamps null: false
    end
  end
end
