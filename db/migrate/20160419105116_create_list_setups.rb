class CreateListSetups < ActiveRecord::Migration
  def change
    create_table :list_setups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
