class CreateNdpObjectives < ActiveRecord::Migration
  def change
    create_table :ndp_objectives, force: :cascade do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
