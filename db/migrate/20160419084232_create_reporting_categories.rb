class CreateReportingCategories < ActiveRecord::Migration
  def change
    create_table :reporting_categories do |t|
      t.string :name
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
