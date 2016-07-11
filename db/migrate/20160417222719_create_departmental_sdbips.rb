class CreateDepartmentalSdbips < ActiveRecord::Migration
  def change
    create_table :departmental_sdbips, force: :cascade do |t|
      t.integer :department_id, foreign_key: true, null: false
      t.string   :department_name, null: false
      t.string   :subdepartment_name, null: false
      t.integer :subdepartment_id, foreign_key: true, null: false
      t.string :kpi_ref_number, null: false
      t.integer :predetermined_objective_id, foreign_key: true
      t.integer :kpi_owner_id, foreign_key: true
      t.text :kpi, null: false
      t.string :unit_of_measurement
      t.integer :mscore_classification_id, foreign_key: true
      t.string :idp_ref
      t.integer :national_outcome_id, foreign_key: true
      t.integer :strategic_objective_id, foreign_key: true
      t.string :source_of_evidence
      t.string :baseline
      t.string :budget
      t.integer :annual_target
      t.integer :revised_target
      t.integer :first_quarter_target
      t.integer :second_quarter_target
      t.integer :third_quarter_target
      t.integer :fourth_quarter_target
      t.text    :performance_comments
      t.text    :corrective_measures
      t.integer :first_quarter_actual
      t.integer :second_quarter_actual
      t.integer :third_quarter_actual
      t.integer :fourth_quarter_actual
      t.binary  :first_quarter_poe
      t.binary  :second_quarter_poe
      t.binary  :third_quarter_poe
      t.binary  :fourth_quarter_poe
      t.string :performance_standard
      t.integer :risk_rating_id, foreign_key: true
      t.integer :kpa_id, foreign_key: true
      t.string :kpa_name
      t.integer :ndp_objective_id, foreign_key: true
      t.integer :capital_project_id, foreign_key: true
      t.integer :kpi_concept_id, foreign_key: true
      t.integer :kpi_type_id, foreign_key: true
      t.string :impact
      t.integer :provincial_strategic_outcome_id, foreign_key: true
      t.integer :ward_id, foreign_key: true
      t.integer :area_id, foreign_key: true
      t.text :past_year_performance
      t.string :performance_standard
      t.integer :reporting_category_id, foreign_key: true
      t.string :top_layer_kpi_ref
      t.integer :kpi_calculation_type_id, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
