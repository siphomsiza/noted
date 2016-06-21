require 'test_helper'

class JobtitleControllerTest < ActionController::TestCase
  test "should get title" do
    get :title
    assert_response :success
  end

end
