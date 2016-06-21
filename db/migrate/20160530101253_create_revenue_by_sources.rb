class CreateRevenueBySources < ActiveRecord::Migration
  def change
    create_table :revenue_by_sources, force: :cascade do |t|
      t.string :vote_number
      t.string :line_item
      t.string :july
      t.string :august
      t.string :september
      t.string :october
      t.string :november
      t.string :december
      t.string :january
      t.string :february
      t.string :march
      t.string :april
      t.string :may
      t.string :june

      t.timestamps null: false
    end
  end
end
