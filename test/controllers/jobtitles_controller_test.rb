require 'test_helper'

class JobtitlesControllerTest < ActionController::TestCase
  setup do
    @jobtitle = jobtitles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobtitles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobtitle" do
    assert_difference('Jobtitle.count') do
      post :create, jobtitle: { title: @jobtitle.title }
    end

    assert_redirected_to jobtitle_path(assigns(:jobtitle))
  end

  test "should show jobtitle" do
    get :show, id: @jobtitle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jobtitle
    assert_response :success
  end

  test "should update jobtitle" do
    patch :update, id: @jobtitle, jobtitle: { title: @jobtitle.title }
    assert_redirected_to jobtitle_path(assigns(:jobtitle))
  end

  test "should destroy jobtitle" do
    assert_difference('Jobtitle.count', -1) do
      delete :destroy, id: @jobtitle
    end

    assert_redirected_to jobtitles_path
  end
end
