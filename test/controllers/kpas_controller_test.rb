require 'test_helper'

class KpasControllerTest < ActionController::TestCase
  setup do
    @kpa = kpas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpa" do
    assert_difference('Kpa.count') do
      post :create, kpa: { name: @kpa.name }
    end

    assert_redirected_to kpa_path(assigns(:kpa))
  end

  test "should show kpa" do
    get :show, id: @kpa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpa
    assert_response :success
  end

  test "should update kpa" do
    patch :update, id: @kpa, kpa: { name: @kpa.name }
    assert_redirected_to kpa_path(assigns(:kpa))
  end

  test "should destroy kpa" do
    assert_difference('Kpa.count', -1) do
      delete :destroy, id: @kpa
    end

    assert_redirected_to kpas_path
  end
end
