class CreateMonthlyCashflows < ActiveRecord::Migration
  def change
    create_table :monthly_cashflows, force: :cascade do |t|
      t.string :month
      t.string :vote_number
      t.integer :subdepartment_id, null:false, foreign_key: true
      t.integer :department_id, null:false, foreign_key: true
      t.integer :mscore_classification_id, null:false, foreign_key: true
      t.string :line_item
      t.decimal :operational_expenditure
      t.decimal :revenue
      t.decimal :capital_expenditure

      t.timestamps null: false
    end
  end
end
