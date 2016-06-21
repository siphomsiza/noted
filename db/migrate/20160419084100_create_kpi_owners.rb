class CreateKpiOwners < ActiveRecord::Migration
  def change
    create_table :kpi_owners do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
