require 'test_helper'

class DepartmentalAdministratorsControllerTest < ActionController::TestCase
  setup do
    @departmental_administrator = departmental_administrators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departmental_administrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create departmental_administrator" do
    assert_difference('DepartmentalAdministrator.count') do
      post :create, departmental_administrator: { can_approve: @departmental_administrator.can_approve, can_create: @departmental_administrator.can_create, can_edit: @departmental_administrator.can_edit, can_update: @departmental_administrator.can_update, department_id: @departmental_administrator.department_id, user_id: @departmental_administrator.user_id }
    end

    assert_redirected_to departmental_administrator_path(assigns(:departmental_administrator))
  end

  test "should show departmental_administrator" do
    get :show, id: @departmental_administrator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @departmental_administrator
    assert_response :success
  end

  test "should update departmental_administrator" do
    patch :update, id: @departmental_administrator, departmental_administrator: { can_approve: @departmental_administrator.can_approve, can_create: @departmental_administrator.can_create, can_edit: @departmental_administrator.can_edit, can_update: @departmental_administrator.can_update, department_id: @departmental_administrator.department_id, user_id: @departmental_administrator.user_id }
    assert_redirected_to departmental_administrator_path(assigns(:departmental_administrator))
  end

  test "should destroy departmental_administrator" do
    assert_difference('DepartmentalAdministrator.count', -1) do
      delete :destroy, id: @departmental_administrator
    end

    assert_redirected_to departmental_administrators_path
  end
end
