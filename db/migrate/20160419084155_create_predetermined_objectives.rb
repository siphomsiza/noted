class CreatePredeterminedObjectives < ActiveRecord::Migration
  def change
    create_table :predetermined_objectives do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
