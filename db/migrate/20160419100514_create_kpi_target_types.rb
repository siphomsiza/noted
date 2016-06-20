class CreateKpiTargetTypes < ActiveRecord::Migration
  def change
    create_table :kpi_target_types do |t|
      t.string :name
      t.string :code
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
