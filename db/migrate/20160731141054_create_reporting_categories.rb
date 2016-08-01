class CreateReportingCategories < ActiveRecord::Migration
  def change
    create_table :reporting_categories, force: :cascade do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
