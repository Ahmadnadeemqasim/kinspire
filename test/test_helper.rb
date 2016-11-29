ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/reporters'
require 'rails/test_help'
require 'test_user_security_helper'

# Use minitest-reporters for test output.
Minitest::Reporters.use!

# Allow simulating secure passwords in fixtures.
ActiveRecord::FixtureSet.context_class.send :include, TestUserSecurityHelper

class ActiveSupport::TestCase
  include TestUserSecurityHelper
  
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  ##
  # Returns true if a test user is logged in, false otherwise.

  def is_logged_in?
    !session[:user_id].nil?
  end
end

class ActionDispatch::IntegrationTest

  ##
  # Log in as the given user.

  def log_in_as( user, password: 'password', remember_login: '1' )
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_login: remember_login } }
  end
end