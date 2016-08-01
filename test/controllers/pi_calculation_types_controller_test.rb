require 'test_helper'

class PiCalculationTypesControllerTest < ActionController::TestCase
  setup do
    @pi_calculation_type = pi_calculation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pi_calculation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pi_calculation_type" do
    assert_difference('PiCalculationType.count') do
      post :create, pi_calculation_type: { code: @pi_calculation_type.code, name: @pi_calculation_type.name }
    end

    assert_redirected_to pi_calculation_type_path(assigns(:pi_calculation_type))
  end

  test "should show pi_calculation_type" do
    get :show, id: @pi_calculation_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pi_calculation_type
    assert_response :success
  end

  test "should update pi_calculation_type" do
    patch :update, id: @pi_calculation_type, pi_calculation_type: { code: @pi_calculation_type.code, name: @pi_calculation_type.name }
    assert_redirected_to pi_calculation_type_path(assigns(:pi_calculation_type))
  end

  test "should destroy pi_calculation_type" do
    assert_difference('PiCalculationType.count', -1) do
      delete :destroy, id: @pi_calculation_type
    end

    assert_redirected_to pi_calculation_types_path
  end
end
