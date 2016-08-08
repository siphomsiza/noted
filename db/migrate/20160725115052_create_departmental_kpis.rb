class CreateDepartmentalKpis < ActiveRecord::Migration
  def change
    create_table :departmental_kpis, force: :cascade do |t|
      t.integer :department_id, foreign_key: true, null: false
      t.string   :department_name, null: false
      t.string   :subdepartment_name, null: false
      t.integer :subdepartment_id, foreign_key: true, null: false
      t.string :kpi_ref_number, index: true, unique: true
      t.integer :predetermined_objective_id
      t.integer :kpi_owner_id
      t.text :kpi
      t.string :unit_of_measurement
      t.integer :mscore_classification_id
      t.string :idp_ref
      t.integer :national_outcome_id
      t.integer :strategic_objective_id
      t.integer :mtas_indicator_id
      t.integer  :kpi_target_type_id
      t.string :source_of_evidence
      t.string :baseline
      t.string :budget
      t.string  :target
      t.decimal :annual_target, default: 0.0
      t.decimal :revised_target
      t.decimal :first_quarter_target
      t.decimal :second_quarter_target
      t.decimal :third_quarter_target
      t.decimal :fourth_quarter_target
      t.text    :performance_comments
      t.text    :corrective_measures
      t.decimal :first_quarter_actual
      t.decimal :second_quarter_actual
      t.decimal :third_quarter_actual
      t.decimal :fourth_quarter_actual
      t.binary  :first_quarter_poe
      t.binary  :second_quarter_poe
      t.binary  :third_quarter_poe
      t.binary  :fourth_quarter_poe
      t.string :performance_standard
      t.integer :risk_rating_id
      t.integer :kpa_id
      t.string :kpa_name
      t.integer :ndp_objective_id
      t.integer :kpi_concept_id
      t.integer :kpi_type_id
      t.string :impact
      t.integer :provincial_strategic_outcome_id
      t.integer :ward_id
      t.integer :area_id
      t.text :past_year_performance
      t.string :performance_standard, default: "KPI Not Yet Measured", null: false
      t.text :performance_comments
      t.text :corrective_measures
      t.integer :reporting_category_id
      t.string :top_layer_kpi_ref
      t.integer :kpi_calculation_type_id
      t.timestamps null: false
    end
  end
end
