ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/reporters'
require 'rails/test_help'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  ##
  # Returns true if a test user is logged in, false otherwise.

  def is_logged_in?
    !session[:user_account_id].nil?
  end
end
