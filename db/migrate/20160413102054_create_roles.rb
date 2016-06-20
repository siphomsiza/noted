class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, force: :cascade do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :kpi_owner_id, foreign_key: true
      t.boolean :kpi_owner, default: false
      t.boolean :finance_admin, default: false
      t.boolean :municipal_manager, default: false
      t.boolean :subdepartmental_administrator, default: false
      t.boolean :departmental_administrator, default: false
      t.boolean :internal_auditor, default: false
      t.boolean :auditor_general, default: false
      t.timestamps null: false
    end
  end
end
