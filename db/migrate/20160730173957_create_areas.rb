class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas, force: :cascade do |t|
      t.string :name, :unique => true

      t.timestamps null: false
    end
  end
end
