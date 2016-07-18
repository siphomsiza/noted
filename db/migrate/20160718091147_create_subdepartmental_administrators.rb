class CreateSubdepartmentalAdministrators < ActiveRecord::Migration
  def change
    create_table :subdepartmental_administrators do |t|
      t.integer :subdepartment_id, default: false
      t.integer :user_id, default: false
      t.boolean :can_create, default: false
      t.boolean :can_edit, default: false
      t.boolean :can_update, default: false
      t.boolean :can_approve, default: false

      t.timestamps null: false
    end
  end
end
