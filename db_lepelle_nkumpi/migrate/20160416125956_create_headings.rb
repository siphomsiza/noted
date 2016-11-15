class CreateHeadings < ActiveRecord::Migration
  def change
    create_table :headings do |t|
      t.string :term
      t.string :description
      t.string :category
      t.timestamps null: false
    end
  end
end
