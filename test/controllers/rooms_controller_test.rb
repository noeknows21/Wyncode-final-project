require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  test "should get create_private" do
    get :create_private
    assert_response :success
  end

end
