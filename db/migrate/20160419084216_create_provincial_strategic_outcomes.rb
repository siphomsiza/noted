class CreateProvincialStrategicOutcomes < ActiveRecord::Migration
  def change
    create_table :provincial_strategic_outcomes do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
