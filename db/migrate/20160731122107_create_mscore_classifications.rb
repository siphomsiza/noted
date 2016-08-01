class CreateMscoreClassifications < ActiveRecord::Migration
  def change
    create_table :mscore_classifications, force: :cascade do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
