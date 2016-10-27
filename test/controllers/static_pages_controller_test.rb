require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index at the root path" do
    get root_path
    assert_response :success
  end

end
