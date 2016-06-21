class CreateRiskRatings < ActiveRecord::Migration
  def change
    create_table :risk_ratings do |t|
      t.string :name
      t.string :code
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
