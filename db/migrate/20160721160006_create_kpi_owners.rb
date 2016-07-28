class CreateKpiOwners < ActiveRecord::Migration
  def change
    create_table :kpi_owners, force: :cascade do |t|
      t.integer :user_id
      t.string :name, :unique => true, :null => false
      t.boolean :can_update, :default => false
      t.timestamps null: false
    end
  end
end
