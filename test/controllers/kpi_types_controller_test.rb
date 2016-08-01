require 'test_helper'

class KpiTypesControllerTest < ActionController::TestCase
  setup do
    @kpi_type = kpi_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpi_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpi_type" do
    assert_difference('KpiType.count') do
      post :create, kpi_type: { name: @kpi_type.name }
    end

    assert_redirected_to kpi_type_path(assigns(:kpi_type))
  end

  test "should show kpi_type" do
    get :show, id: @kpi_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpi_type
    assert_response :success
  end

  test "should update kpi_type" do
    patch :update, id: @kpi_type, kpi_type: { name: @kpi_type.name }
    assert_redirected_to kpi_type_path(assigns(:kpi_type))
  end

  test "should destroy kpi_type" do
    assert_difference('KpiType.count', -1) do
      delete :destroy, id: @kpi_type
    end

    assert_redirected_to kpi_types_path
  end
end
