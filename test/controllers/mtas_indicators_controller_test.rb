require 'test_helper'

class MtasIndicatorsControllerTest < ActionController::TestCase
  setup do
    @mtas_indicator = mtas_indicators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mtas_indicators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mtas_indicator" do
    assert_difference('MtasIndicator.count') do
      post :create, mtas_indicator: { name: @mtas_indicator.name }
    end

    assert_redirected_to mtas_indicator_path(assigns(:mtas_indicator))
  end

  test "should show mtas_indicator" do
    get :show, id: @mtas_indicator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mtas_indicator
    assert_response :success
  end

  test "should update mtas_indicator" do
    patch :update, id: @mtas_indicator, mtas_indicator: { name: @mtas_indicator.name }
    assert_redirected_to mtas_indicator_path(assigns(:mtas_indicator))
  end

  test "should destroy mtas_indicator" do
    assert_difference('MtasIndicator.count', -1) do
      delete :destroy, id: @mtas_indicator
    end

    assert_redirected_to mtas_indicators_path
  end
end
