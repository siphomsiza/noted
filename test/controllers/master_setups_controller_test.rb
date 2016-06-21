require 'test_helper'

class MasterSetupsControllerTest < ActionController::TestCase
  setup do
    @master_setup = master_setups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_setups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_setup" do
    assert_difference('MasterSetup.count') do
      post :create, master_setup: { municipality: @master_setup.municipality }
    end

    assert_redirected_to master_setup_path(assigns(:master_setup))
  end

  test "should show master_setup" do
    get :show, id: @master_setup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_setup
    assert_response :success
  end

  test "should update master_setup" do
    patch :update, id: @master_setup, master_setup: { municipality: @master_setup.municipality }
    assert_redirected_to master_setup_path(assigns(:master_setup))
  end

  test "should destroy master_setup" do
    assert_difference('MasterSetup.count', -1) do
      delete :destroy, id: @master_setup
    end

    assert_redirected_to master_setups_path
  end
end
