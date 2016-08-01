class CreateKpiCalculationTypes < ActiveRecord::Migration
  def change
    create_table :kpi_calculation_types, force: :cascade do |t|
      t.string :name
      t.string :code
      t.text :description
      t.timestamps null: false
    end
  end
end
