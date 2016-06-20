class CreateKpiCalculationTypes < ActiveRecord::Migration
  def change
    create_table :kpi_calculation_types do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
