class CreateMtasIndicators < ActiveRecord::Migration
  def change
    create_table :mtas_indicators do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
