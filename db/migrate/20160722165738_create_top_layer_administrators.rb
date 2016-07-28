class CreateTopLayerAdministrators < ActiveRecord::Migration
  def change
    create_table :top_layer_administrators, force: :cascade do |t|
      t.integer :user_id, :null => false, :unique => true
      t.integer :department_id, :null => false
      t.boolean :can_edit, :default => false
      t.boolean :can_create, :default => false
      t.boolean :can_approve, :default => false
      t.boolean :can_update, :default => false
      t.timestamps null: false
    end
  end
end
