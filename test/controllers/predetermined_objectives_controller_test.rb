require 'test_helper'

class PredeterminedObjectivesControllerTest < ActionController::TestCase
  setup do
    @predetermined_objective = predetermined_objectives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:predetermined_objectives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create predetermined_objective" do
    assert_difference('PredeterminedObjective.count') do
      post :create, predetermined_objective: { name: @predetermined_objective.name }
    end

    assert_redirected_to predetermined_objective_path(assigns(:predetermined_objective))
  end

  test "should show predetermined_objective" do
    get :show, id: @predetermined_objective
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @predetermined_objective
    assert_response :success
  end

  test "should update predetermined_objective" do
    patch :update, id: @predetermined_objective, predetermined_objective: { name: @predetermined_objective.name }
    assert_redirected_to predetermined_objective_path(assigns(:predetermined_objective))
  end

  test "should destroy predetermined_objective" do
    assert_difference('PredeterminedObjective.count', -1) do
      delete :destroy, id: @predetermined_objective
    end

    assert_redirected_to predetermined_objectives_path
  end
end
