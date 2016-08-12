class CreateProvincialStrategicOutcomes < ActiveRecord::Migration
  def change
    create_table :provincial_strategic_outcomes, force: :cascade do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
