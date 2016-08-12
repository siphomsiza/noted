class CreateTopLayerSdbips < ActiveRecord::Migration
  def change
    create_table :top_layer_sdbips do |t|
      t.integer :department_id, null:false, foreign_key: true
      t.boolean :reporting_kpi, null:false, default: false
      t.string :idp_ref
      t.integer :mscore_classification_id, null:false, foreign_key: true
      t.integer :national_outcome_id, null:false, foreign_key: true
      t.integer :kpa_id, null:false, foreign_key: true
      t.integer :predetermined_objective_id, null:false, foreign_key: true
      t.integer :ndp_objective_id, null:false, foreign_key: true
      t.integer :strategic_objective_id, null:false, foreign_key: true
      t.text :kpi
      t.text :unit_of_measurement
      t.text :risk
      t.integer :ward_id, null:false, foreign_key: true
      t.integer :area_id, null:false, foreign_key: true
      t.integer :kpi_owner_id, null:false, foreign_key: true
      t.string :baseline
      t.binary :poe
      t.text :past_year_performance
      t.integer :mtas_indicator_id, null:false, foreign_key: true
      t.string :reporting_category
      t.integer :kpi_calculation_type_id, null:false, foreign_key: true
      t.integer :kpi_target_type_id, null:false, foreign_key: true
      t.decimal :annual_target
      t.decimal :revised_target
      t.decimal :first_quarter_target
      t.decimal :second_quarter_target
      t.decimal :third_quarter_target
      t.decimal :fourth_quarter_target
      t.decimal :first_quarter_actual
      t.decimal :second_quarter_actual
      t.decimal :third_quarter_actual
      t.decimal :fourth_quarter_actual
      t.timestamps null: false
    end
  end
end
