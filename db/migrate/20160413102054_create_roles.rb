class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, force: :cascade do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.boolean :kpi_owner, default: false
      t.boolean :finance_admin, default: false
      t.boolean :top_layer_administrator, default: false
      t.boolean :assurance_provider, default: false
      t.boolean :audit_log_reporting, default: false
      t.boolean :secondary_time_period, default: false
      t.boolean :setup, default: false
      t.timestamps null: false
    end
  end
end
