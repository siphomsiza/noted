require 'test_helper'

class StrategicObjectivesControllerTest < ActionController::TestCase
  setup do
    @strategic_objective = strategic_objectives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:strategic_objectives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create strategic_objective" do
    assert_difference('StrategicObjective.count') do
      post :create, strategic_objective: { name: @strategic_objective.name }
    end

    assert_redirected_to strategic_objective_path(assigns(:strategic_objective))
  end

  test "should show strategic_objective" do
    get :show, id: @strategic_objective
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @strategic_objective
    assert_response :success
  end

  test "should update strategic_objective" do
    patch :update, id: @strategic_objective, strategic_objective: { name: @strategic_objective.name }
    assert_redirected_to strategic_objective_path(assigns(:strategic_objective))
  end

  test "should destroy strategic_objective" do
    assert_difference('StrategicObjective.count', -1) do
      delete :destroy, id: @strategic_objective
    end

    assert_redirected_to strategic_objectives_path
  end
end
