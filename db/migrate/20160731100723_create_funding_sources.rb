class CreateFundingSources < ActiveRecord::Migration
  def change
    create_table :funding_sources, force: :cascade do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
