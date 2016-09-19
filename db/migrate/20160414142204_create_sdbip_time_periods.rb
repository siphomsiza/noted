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
      t.boolean  :primary_notification_sent,     default: false
      t.boolean  :secondary_notification_sent,     default: false
      t.boolean  :finance_notification_sent,     default: false
      t.boolean :primary_status, :default => true
      t.boolean :secondary_status, :default => true
      t.boolean :finance_status, :default => true
      t.timestamps null: false
    end
  end
end
