require 'test_helper'

class KpiOwnersControllerTest < ActionController::TestCase
  setup do
    @kpi_owner = kpi_owners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpi_owners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpi_owner" do
    assert_difference('KpiOwner.count') do
      post :create, kpi_owner: { title: @kpi_owner.title, user_id: @kpi_owner.user_id }
    end

    assert_redirected_to kpi_owner_path(assigns(:kpi_owner))
  end

  test "should show kpi_owner" do
    get :show, id: @kpi_owner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpi_owner
    assert_response :success
  end

  test "should update kpi_owner" do
    patch :update, id: @kpi_owner, kpi_owner: { title: @kpi_owner.title, user_id: @kpi_owner.user_id }
    assert_redirected_to kpi_owner_path(assigns(:kpi_owner))
  end

  test "should destroy kpi_owner" do
    assert_difference('KpiOwner.count', -1) do
      delete :destroy, id: @kpi_owner
    end

    assert_redirected_to kpi_owners_path
  end
end
