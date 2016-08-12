class CreateKpiTargetTypes < ActiveRecord::Migration
  def change
    create_table :kpi_target_types, force: :cascade do |t|
      t.string :name
      t.string :code
      t.timestamps null: false
    end
  end
end
