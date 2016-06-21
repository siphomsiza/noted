class CreateNationalOutcomes < ActiveRecord::Migration
  def change
    create_table :national_outcomes do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
