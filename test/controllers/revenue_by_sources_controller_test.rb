require 'test_helper'

class RevenueBySourcesControllerTest < ActionController::TestCase
  setup do
    @revenue_by_source = revenue_by_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:revenue_by_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create revenue_by_source" do
    assert_difference('RevenueBySource.count') do
      post :create, revenue_by_source: { April: @revenue_by_source.April, August: @revenue_by_source.August, December: @revenue_by_source.December, February: @revenue_by_source.February, January: @revenue_by_source.January, July: @revenue_by_source.July, June: @revenue_by_source.June, March: @revenue_by_source.March, May: @revenue_by_source.May, November: @revenue_by_source.November, October: @revenue_by_source.October, September: @revenue_by_source.September, line_item: @revenue_by_source.line_item, vote_number: @revenue_by_source.vote_number }
    end

    assert_redirected_to revenue_by_source_path(assigns(:revenue_by_source))
  end

  test "should show revenue_by_source" do
    get :show, id: @revenue_by_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @revenue_by_source
    assert_response :success
  end

  test "should update revenue_by_source" do
    patch :update, id: @revenue_by_source, revenue_by_source: { April: @revenue_by_source.April, August: @revenue_by_source.August, December: @revenue_by_source.December, February: @revenue_by_source.February, January: @revenue_by_source.January, July: @revenue_by_source.July, June: @revenue_by_source.June, March: @revenue_by_source.March, May: @revenue_by_source.May, November: @revenue_by_source.November, October: @revenue_by_source.October, September: @revenue_by_source.September, line_item: @revenue_by_source.line_item, vote_number: @revenue_by_source.vote_number }
    assert_redirected_to revenue_by_source_path(assigns(:revenue_by_source))
  end

  test "should destroy revenue_by_source" do
    assert_difference('RevenueBySource.count', -1) do
      delete :destroy, id: @revenue_by_source
    end

    assert_redirected_to revenue_by_sources_path
  end
end
