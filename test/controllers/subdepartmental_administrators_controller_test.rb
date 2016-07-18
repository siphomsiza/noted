require 'test_helper'

class SubdepartmentalAdministratorsControllerTest < ActionController::TestCase
  setup do
    @subdepartmental_administrator = subdepartmental_administrators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subdepartmental_administrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subdepartmental_administrator" do
    assert_difference('SubdepartmentalAdministrator.count') do
      post :create, subdepartmental_administrator: { can_approve: @subdepartmental_administrator.can_approve, can_create: @subdepartmental_administrator.can_create, can_edit: @subdepartmental_administrator.can_edit, can_update: @subdepartmental_administrator.can_update, department_id: @subdepartmental_administrator.department_id, user_id: @subdepartmental_administrator.user_id }
    end

    assert_redirected_to subdepartmental_administrator_path(assigns(:subdepartmental_administrator))
  end

  test "should show subdepartmental_administrator" do
    get :show, id: @subdepartmental_administrator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subdepartmental_administrator
    assert_response :success
  end

  test "should update subdepartmental_administrator" do
    patch :update, id: @subdepartmental_administrator, subdepartmental_administrator: { can_approve: @subdepartmental_administrator.can_approve, can_create: @subdepartmental_administrator.can_create, can_edit: @subdepartmental_administrator.can_edit, can_update: @subdepartmental_administrator.can_update, department_id: @subdepartmental_administrator.department_id, user_id: @subdepartmental_administrator.user_id }
    assert_redirected_to subdepartmental_administrator_path(assigns(:subdepartmental_administrator))
  end

  test "should destroy subdepartmental_administrator" do
    assert_difference('SubdepartmentalAdministrator.count', -1) do
      delete :destroy, id: @subdepartmental_administrator
    end

    assert_redirected_to subdepartmental_administrators_path
  end
end
