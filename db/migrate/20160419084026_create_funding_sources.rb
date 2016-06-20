class CreateFundingSources < ActiveRecord::Migration
  def change
    create_table :funding_sources do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
