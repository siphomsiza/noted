class CreateSdbipTimePeriods < ActiveRecord::Migration
  def change
    create_table :sdbip_time_periods do |t|

      t.date :period, :unique => true, :null => false
      t.date :primary_reminder
   	  t.date :secondary_reminder
      t.date :primary_closure
      t.date :secondary_closure
      t.date :finance_reminder
      t.date :finance_closure
      t.boolean :primary_status, :default => false
      t.boolean :secondary_status, :default => false
      t.boolean :finance_status, :default => false
      t.timestamps null: false
    end
  end
end
