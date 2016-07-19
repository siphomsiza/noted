class CreateCapitalProjects < ActiveRecord::Migration
  def change
    create_table :capital_projects, force: :cascade do |t|
      t.integer :subdepartment_id, null: false
      t.integer :mscore_classification_id, null: false
      t.integer :departmental_sdbip_id, null: false
      t.string :mun_cp_ref
      t.string :idp_nummber
      t.string :vote_number
      t.string :project_name
      t.string :funding_source
      t.date :planned_start_date
      t.date :planned_completion_date
      t.date :actual_start_date
      t.date :actual_completion_date
      t.integer :ward_id
      t.integer :area_id
      t.timestamps null: false

    end

  end
end
