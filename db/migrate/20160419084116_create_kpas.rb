class CreateKpas < ActiveRecord::Migration
  def change
    create_table :kpas do |t|
      t.string :name
      t.string :code
      t.integer :list_id, foreign_key: true
      t.timestamps null: false
    end
  end
end
