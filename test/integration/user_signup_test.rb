require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "user submits invalid signup data" do
    get signup_path
    assert_response :success, "Visit signup path unsucessful."

    assert_no_difference 'User.count', "Invalid signup submission should not cause a new User to be created." do
      post users_path, params: { user: {  email:                "invalid",
                                          password:             "foo",
                                          assword_confirmation: "bar" } } 
    end
    assert_response :success,     "Invalid signup submission should not cause an HTTP failure."
    assert_not is_logged_in?,     "Invalid signup submission should not cause a user to be logged in."
    assert_template 'users/new',  "Sign up form should be rerendered after invalid signup submission."
  end

  test "user submits valid signup data" do
    email     = "valid@email.com"
    password  = standard_password

    get signup_path
    assert_response :success, "Visit signup path unsucessful."

    assert_difference 'User.count', 1, "Valid signup submission should create a new user." do
      post users_path, params: { user: {  email:                  email,
                                          password:               password,
                                          password_confirmation:  password } }
    end
    assert is_logged_in?,                               "Successful signup should log the new user in immediately."
    assert_redirected_to User.find_by( email: email ),  "Successful signup should redirect to the new user's homepage."
    follow_redirect!
    assert_template 'users/show',                       "Successful signup should render the new user's show page."
  end
end
