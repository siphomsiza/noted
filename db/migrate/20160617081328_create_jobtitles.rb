class CreateJobtitles < ActiveRecord::Migration
  def change
    create_table :jobtitles, force: :cascade do |t|
      t.string :title
      t.timestamps null: false
    end
  end
end
