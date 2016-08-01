require 'test_helper'

class NationalOutcomesControllerTest < ActionController::TestCase
  setup do
    @national_outcome = national_outcomes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:national_outcomes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create national_outcome" do
    assert_difference('NationalOutcome.count') do
      post :create, national_outcome: { name: @national_outcome.name }
    end

    assert_redirected_to national_outcome_path(assigns(:national_outcome))
  end

  test "should show national_outcome" do
    get :show, id: @national_outcome
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @national_outcome
    assert_response :success
  end

  test "should update national_outcome" do
    patch :update, id: @national_outcome, national_outcome: { name: @national_outcome.name }
    assert_redirected_to national_outcome_path(assigns(:national_outcome))
  end

  test "should destroy national_outcome" do
    assert_difference('NationalOutcome.count', -1) do
      delete :destroy, id: @national_outcome
    end

    assert_redirected_to national_outcomes_path
  end
end
