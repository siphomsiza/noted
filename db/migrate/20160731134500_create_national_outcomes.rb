class CreateNationalOutcomes < ActiveRecord::Migration
  def change
    create_table :national_outcomes, force: :cascade do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
