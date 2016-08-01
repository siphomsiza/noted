require 'test_helper'

class KpiTargetTypesControllerTest < ActionController::TestCase
  setup do
    @kpi_target_type = kpi_target_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpi_target_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpi_target_type" do
    assert_difference('KpiTargetType.count') do
      post :create, kpi_target_type: { code: @kpi_target_type.code, name: @kpi_target_type.name }
    end

    assert_redirected_to kpi_target_type_path(assigns(:kpi_target_type))
  end

  test "should show kpi_target_type" do
    get :show, id: @kpi_target_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpi_target_type
    assert_response :success
  end

  test "should update kpi_target_type" do
    patch :update, id: @kpi_target_type, kpi_target_type: { code: @kpi_target_type.code, name: @kpi_target_type.name }
    assert_redirected_to kpi_target_type_path(assigns(:kpi_target_type))
  end

  test "should destroy kpi_target_type" do
    assert_difference('KpiTargetType.count', -1) do
      delete :destroy, id: @kpi_target_type
    end

    assert_redirected_to kpi_target_types_path
  end
end
