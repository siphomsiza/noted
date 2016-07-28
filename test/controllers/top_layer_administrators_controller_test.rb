require 'test_helper'

class TopLayerAdministratorsControllerTest < ActionController::TestCase
  setup do
    @top_layer_administrator = top_layer_administrators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:top_layer_administrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create top_layer_administrator" do
    assert_difference('TopLayerAdministrator.count') do
      post :create, top_layer_administrator: { can_approve: @top_layer_administrator.can_approve, can_create: @top_layer_administrator.can_create, can_edit: @top_layer_administrator.can_edit, can_update: @top_layer_administrator.can_update, user_id: @top_layer_administrator.user_id }
    end

    assert_redirected_to top_layer_administrator_path(assigns(:top_layer_administrator))
  end

  test "should show top_layer_administrator" do
    get :show, id: @top_layer_administrator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @top_layer_administrator
    assert_response :success
  end

  test "should update top_layer_administrator" do
    patch :update, id: @top_layer_administrator, top_layer_administrator: { can_approve: @top_layer_administrator.can_approve, can_create: @top_layer_administrator.can_create, can_edit: @top_layer_administrator.can_edit, can_update: @top_layer_administrator.can_update, user_id: @top_layer_administrator.user_id }
    assert_redirected_to top_layer_administrator_path(assigns(:top_layer_administrator))
  end

  test "should destroy top_layer_administrator" do
    assert_difference('TopLayerAdministrator.count', -1) do
      delete :destroy, id: @top_layer_administrator
    end

    assert_redirected_to top_layer_administrators_path
  end
end
