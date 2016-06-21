class CreateSdbipTimePeriods < ActiveRecord::Migration
  def change
    create_table :sdbip_time_periods do |t|

      t.string :period
      t.date   :start_date
      t.date   :end_date
      t.integer :departmental_sdbip_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
