json.array!(@top_layer_sdbips) do |top_layer_sdbip|
  json.extract! top_layer_sdbip, :id, :department_id, :reporting_kpi, :idp_ref, :mscore_classification_id, :national_outcome_id, :kpa_id, :predetermined_objective_id, :ndp_objective_id, :strategic_objective_id, :kpi, :unit_of_measurement, :risk, :ward_id, :area_id, :kpi_owner_id, :baseline, :poe, :past_year_performance, :mtas_indicator_id, :reporting_category, :kpi_calculation_type_id, :kpi_target_type_id, :annual_target, :revised_target, :first_quarter_target, :second_quarter_target, :third_quarter_target, :fourth_quarter_target, :first_quarter_actual, :second_quarter_actual, :third_quarter_actual, :fourth_quarter_actual
  json.url top_layer_sdbip_url(top_layer_sdbip, format: :json)
end
