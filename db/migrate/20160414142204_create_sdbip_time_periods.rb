class CreateSdbipTimePeriods < ActiveRecord::Migration
  def change
    create_table :sdbip_time_periods do |t|

      t.string :period, :unique => true, :null => false
      t.date   :start_date, :null => false
      t.date   :end_date, :null => false
      t.integer :departmental_sdbip_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
