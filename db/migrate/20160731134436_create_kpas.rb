class CreateKpas < ActiveRecord::Migration
  def change
    create_table :kpas, force: :cascade do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.timestamps null: false
    end
  end
end
