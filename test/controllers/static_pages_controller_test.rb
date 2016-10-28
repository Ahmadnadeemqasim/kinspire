require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index at the root path" do
    # Should be at the root path.
    get root_path
    assert_response :success

    # Should have the correct HTML title.
    assert_select "title", "Index | Kinspire"
  end

end
