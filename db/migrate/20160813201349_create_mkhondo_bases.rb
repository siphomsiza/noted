class CreateMkhondoBases < ActiveRecord::Migration
  def change
    create_table :mkhondo_bases do |t|

      t.timestamps null: false
    end
  end
end
