class CreateActivities < ActiveRecord::Migration
  def change
     create_table :activities, :force => true do |t|
       t.string :user_id, :null => false
       t.string :browser
       t.string :ip_address
       t.string :params
       t.integer :departmental_sdbip_id, :null => false
       t.timestamps null: false
    end
  end
end
