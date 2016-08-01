require 'test_helper'

class MscoreClassificationsControllerTest < ActionController::TestCase
  setup do
    @mscore_classification = mscore_classifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mscore_classifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mscore_classification" do
    assert_difference('MscoreClassification.count') do
      post :create, mscore_classification: { name: @mscore_classification.name }
    end

    assert_redirected_to mscore_classification_path(assigns(:mscore_classification))
  end

  test "should show mscore_classification" do
    get :show, id: @mscore_classification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mscore_classification
    assert_response :success
  end

  test "should update mscore_classification" do
    patch :update, id: @mscore_classification, mscore_classification: { name: @mscore_classification.name }
    assert_redirected_to mscore_classification_path(assigns(:mscore_classification))
  end

  test "should destroy mscore_classification" do
    assert_difference('MscoreClassification.count', -1) do
      delete :destroy, id: @mscore_classification
    end

    assert_redirected_to mscore_classifications_path
  end
end
