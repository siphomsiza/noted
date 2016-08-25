class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :kpi_result_id, null: false
      t.timestamps null: false
    end
  end
end
