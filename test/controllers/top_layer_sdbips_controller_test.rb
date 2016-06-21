require 'test_helper'

class TopLayerSdbipsControllerTest < ActionController::TestCase
  setup do
    @top_layer_sdbip = top_layer_sdbips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:top_layer_sdbips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create top_layer_sdbip" do
    assert_difference('TopLayerSdbip.count') do
      post :create, top_layer_sdbip: { annual_target: @top_layer_sdbip.annual_target, area_id: @top_layer_sdbip.area_id, baseline: @top_layer_sdbip.baseline, department_id: @top_layer_sdbip.department_id, first_quarter_actual: @top_layer_sdbip.first_quarter_actual, first_quarter_target: @top_layer_sdbip.first_quarter_target, fourth_quarter_actual: @top_layer_sdbip.fourth_quarter_actual, fourth_quarter_target: @top_layer_sdbip.fourth_quarter_target, idp_ref: @top_layer_sdbip.idp_ref, kpa_id: @top_layer_sdbip.kpa_id, kpi: @top_layer_sdbip.kpi, kpi_calculation_type_id: @top_layer_sdbip.kpi_calculation_type_id, kpi_owner_id: @top_layer_sdbip.kpi_owner_id, kpi_target_type_id: @top_layer_sdbip.kpi_target_type_id, mscore_classification_id: @top_layer_sdbip.mscore_classification_id, mtas_indicator_id: @top_layer_sdbip.mtas_indicator_id, national_outcome_id: @top_layer_sdbip.national_outcome_id, ndp_objective_id: @top_layer_sdbip.ndp_objective_id, past_year_performance: @top_layer_sdbip.past_year_performance, poe: @top_layer_sdbip.poe, predetermined_objective_id: @top_layer_sdbip.predetermined_objective_id, reporting_category: @top_layer_sdbip.reporting_category, reporting_kpi: @top_layer_sdbip.reporting_kpi, revised_target: @top_layer_sdbip.revised_target, risk: @top_layer_sdbip.risk, second_quarter_actual: @top_layer_sdbip.second_quarter_actual, second_quarter_target: @top_layer_sdbip.second_quarter_target, strategic_objective_id: @top_layer_sdbip.strategic_objective_id, third_quarter_actual: @top_layer_sdbip.third_quarter_actual, third_quarter_target: @top_layer_sdbip.third_quarter_target, unit_of_measurement: @top_layer_sdbip.unit_of_measurement, ward_id: @top_layer_sdbip.ward_id }
    end

    assert_redirected_to top_layer_sdbip_path(assigns(:top_layer_sdbip))
  end

  test "should show top_layer_sdbip" do
    get :show, id: @top_layer_sdbip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @top_layer_sdbip
    assert_response :success
  end

  test "should update top_layer_sdbip" do
    patch :update, id: @top_layer_sdbip, top_layer_sdbip: { annual_target: @top_layer_sdbip.annual_target, area_id: @top_layer_sdbip.area_id, baseline: @top_layer_sdbip.baseline, department_id: @top_layer_sdbip.department_id, first_quarter_actual: @top_layer_sdbip.first_quarter_actual, first_quarter_target: @top_layer_sdbip.first_quarter_target, fourth_quarter_actual: @top_layer_sdbip.fourth_quarter_actual, fourth_quarter_target: @top_layer_sdbip.fourth_quarter_target, idp_ref: @top_layer_sdbip.idp_ref, kpa_id: @top_layer_sdbip.kpa_id, kpi: @top_layer_sdbip.kpi, kpi_calculation_type_id: @top_layer_sdbip.kpi_calculation_type_id, kpi_owner_id: @top_layer_sdbip.kpi_owner_id, kpi_target_type_id: @top_layer_sdbip.kpi_target_type_id, mscore_classification_id: @top_layer_sdbip.mscore_classification_id, mtas_indicator_id: @top_layer_sdbip.mtas_indicator_id, national_outcome_id: @top_layer_sdbip.national_outcome_id, ndp_objective_id: @top_layer_sdbip.ndp_objective_id, past_year_performance: @top_layer_sdbip.past_year_performance, poe: @top_layer_sdbip.poe, predetermined_objective_id: @top_layer_sdbip.predetermined_objective_id, reporting_category: @top_layer_sdbip.reporting_category, reporting_kpi: @top_layer_sdbip.reporting_kpi, revised_target: @top_layer_sdbip.revised_target, risk: @top_layer_sdbip.risk, second_quarter_actual: @top_layer_sdbip.second_quarter_actual, second_quarter_target: @top_layer_sdbip.second_quarter_target, strategic_objective_id: @top_layer_sdbip.strategic_objective_id, third_quarter_actual: @top_layer_sdbip.third_quarter_actual, third_quarter_target: @top_layer_sdbip.third_quarter_target, unit_of_measurement: @top_layer_sdbip.unit_of_measurement, ward_id: @top_layer_sdbip.ward_id }
    assert_redirected_to top_layer_sdbip_path(assigns(:top_layer_sdbip))
  end

  test "should destroy top_layer_sdbip" do
    assert_difference('TopLayerSdbip.count', -1) do
      delete :destroy, id: @top_layer_sdbip
    end

    assert_redirected_to top_layer_sdbips_path
  end
end
