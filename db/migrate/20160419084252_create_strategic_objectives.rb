class CreateStrategicObjectives < ActiveRecord::Migration
  def change
    create_table :strategic_objectives do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
