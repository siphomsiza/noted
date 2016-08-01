class CreateAssurances < ActiveRecord::Migration
  def change
    create_table :assurances do |t|
      t.integer :departmental_sdbip_id,            null: false
      t.integer :user_id
      t.boolean :signed_off
      t.text :response
      t.integer :kpi_result_id
      t.binary :poe

      t.timestamps null: false
    end
  end
end
