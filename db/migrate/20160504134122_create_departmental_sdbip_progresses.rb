class CreateDepartmentalSdbipProgresses < ActiveRecord::Migration
  def change
    create_table :departmental_sdbip_progresses do |t|
      t.string :period
      t.string :actual
      t.binary :poe
      t.text :corrective_measures
      t.text :comments
      t.integer :departmental_sdbip_id, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end
