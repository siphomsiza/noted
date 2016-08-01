class CreateRiskRatings < ActiveRecord::Migration
  def change
    create_table :risk_ratings, force: :cascade do |t|
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
