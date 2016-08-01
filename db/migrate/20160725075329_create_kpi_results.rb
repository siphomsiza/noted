class CreateKpiResults < ActiveRecord::Migration
  def change
    create_table :kpi_results do |t|
      t.date :period
      t.integer :departmental_sdbip_id
      t.integer :user_id
      t.decimal :target
      t.decimal :actual
      t.text :corrective_measures
      t.text :performance_comments
      t.string :kpi_performance_standard

      t.timestamps null: false
    end
  end
end
