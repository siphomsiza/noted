require 'test_helper'

class KpiCalculationTypesControllerTest < ActionController::TestCase
  setup do
    @kpi_calculation_type = kpi_calculation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpi_calculation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpi_calculation_type" do
    assert_difference('KpiCalculationType.count') do
      post :create, kpi_calculation_type: { code: @kpi_calculation_type.code, name: @kpi_calculation_type.name }
    end

    assert_redirected_to kpi_calculation_type_path(assigns(:kpi_calculation_type))
  end

  test "should show kpi_calculation_type" do
    get :show, id: @kpi_calculation_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpi_calculation_type
    assert_response :success
  end

  test "should update kpi_calculation_type" do
    patch :update, id: @kpi_calculation_type, kpi_calculation_type: { code: @kpi_calculation_type.code, name: @kpi_calculation_type.name }
    assert_redirected_to kpi_calculation_type_path(assigns(:kpi_calculation_type))
  end

  test "should destroy kpi_calculation_type" do
    assert_difference('KpiCalculationType.count', -1) do
      delete :destroy, id: @kpi_calculation_type
    end

    assert_redirected_to kpi_calculation_types_path
  end
end
