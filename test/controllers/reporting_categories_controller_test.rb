require 'test_helper'

class ReportingCategoriesControllerTest < ActionController::TestCase
  setup do
    @reporting_category = reporting_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reporting_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reporting_category" do
    assert_difference('ReportingCategory.count') do
      post :create, reporting_category: { name: @reporting_category.name }
    end

    assert_redirected_to reporting_category_path(assigns(:reporting_category))
  end

  test "should show reporting_category" do
    get :show, id: @reporting_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reporting_category
    assert_response :success
  end

  test "should update reporting_category" do
    patch :update, id: @reporting_category, reporting_category: { name: @reporting_category.name }
    assert_redirected_to reporting_category_path(assigns(:reporting_category))
  end

  test "should destroy reporting_category" do
    assert_difference('ReportingCategory.count', -1) do
      delete :destroy, id: @reporting_category
    end

    assert_redirected_to reporting_categories_path
  end
end
