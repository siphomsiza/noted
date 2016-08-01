class CreateKpiTypes < ActiveRecord::Migration
  def change
    create_table :kpi_types, force: :cascade do |t|
      t.string :name
      t.string :code, null: false
      t.timestamps null: false
    end
  end
end
