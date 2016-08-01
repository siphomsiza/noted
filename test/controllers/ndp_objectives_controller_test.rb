require 'test_helper'

class NdpObjectivesControllerTest < ActionController::TestCase
  setup do
    @ndp_objective = ndp_objectives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ndp_objectives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ndp_objective" do
    assert_difference('NdpObjective.count') do
      post :create, ndp_objective: { name: @ndp_objective.name }
    end

    assert_redirected_to ndp_objective_path(assigns(:ndp_objective))
  end

  test "should show ndp_objective" do
    get :show, id: @ndp_objective
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ndp_objective
    assert_response :success
  end

  test "should update ndp_objective" do
    patch :update, id: @ndp_objective, ndp_objective: { name: @ndp_objective.name }
    assert_redirected_to ndp_objective_path(assigns(:ndp_objective))
  end

  test "should destroy ndp_objective" do
    assert_difference('NdpObjective.count', -1) do
      delete :destroy, id: @ndp_objective
    end

    assert_redirected_to ndp_objectives_path
  end
end
