class CreateKpiConcepts < ActiveRecord::Migration
  def change
    create_table :kpi_concepts, force: :cascade do |t|
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
