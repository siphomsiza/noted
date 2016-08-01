require 'test_helper'

class ProvincialStrategicOutcomesControllerTest < ActionController::TestCase
  setup do
    @provincial_strategic_outcome = provincial_strategic_outcomes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provincial_strategic_outcomes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provincial_strategic_outcome" do
    assert_difference('ProvincialStrategicOutcome.count') do
      post :create, provincial_strategic_outcome: { name: @provincial_strategic_outcome.name }
    end

    assert_redirected_to provincial_strategic_outcome_path(assigns(:provincial_strategic_outcome))
  end

  test "should show provincial_strategic_outcome" do
    get :show, id: @provincial_strategic_outcome
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provincial_strategic_outcome
    assert_response :success
  end

  test "should update provincial_strategic_outcome" do
    patch :update, id: @provincial_strategic_outcome, provincial_strategic_outcome: { name: @provincial_strategic_outcome.name }
    assert_redirected_to provincial_strategic_outcome_path(assigns(:provincial_strategic_outcome))
  end

  test "should destroy provincial_strategic_outcome" do
    assert_difference('ProvincialStrategicOutcome.count', -1) do
      delete :destroy, id: @provincial_strategic_outcome
    end

    assert_redirected_to provincial_strategic_outcomes_path
  end
end
