class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs, :force => true do |t|
      t.string "user_id"
      t.string "admin", :default => false
      t.string "browser"
      t.string "ip_address"
      t.string "controller"
      t.string "action"
      t.string "params"
      t.string "note"
      t.timestamps null: false
    end
  end
end
