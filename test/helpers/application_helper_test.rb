class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper
  
  test "function html_title should take zero or one string arguments and return a correctly formatted string based on the argument passed" do
    assert_equal    html_title(),                   Company.strings[:company_name]
    assert_equal    html_title( "A Test Title" ),   "A Test Title | #{Company.strings[:company_name]}"
  end
end