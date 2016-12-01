require 'test_helper'

class UserForgotPasswordTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'user_forgot_password' do
    get '/users/confirmation/new'
    assert_response :success
      post "/challenges",
      params: { user: { email: "test@example.com"} ,}
      

  end

end
