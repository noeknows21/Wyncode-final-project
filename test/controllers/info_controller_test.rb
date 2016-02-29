require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "should get about_tech" do
    get :about_tech
    assert_response :success
  end

end
