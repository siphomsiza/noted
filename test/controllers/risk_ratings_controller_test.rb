require 'test_helper'

class RiskRatingsControllerTest < ActionController::TestCase
  setup do
    @risk_rating = risk_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:risk_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create risk_rating" do
    assert_difference('RiskRating.count') do
      post :create, risk_rating: { code: @risk_rating.code, name: @risk_rating.name }
    end

    assert_redirected_to risk_rating_path(assigns(:risk_rating))
  end

  test "should show risk_rating" do
    get :show, id: @risk_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @risk_rating
    assert_response :success
  end

  test "should update risk_rating" do
    patch :update, id: @risk_rating, risk_rating: { code: @risk_rating.code, name: @risk_rating.name }
    assert_redirected_to risk_rating_path(assigns(:risk_rating))
  end

  test "should destroy risk_rating" do
    assert_difference('RiskRating.count', -1) do
      delete :destroy, id: @risk_rating
    end

    assert_redirected_to risk_ratings_path
  end
end
