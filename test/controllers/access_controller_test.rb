require 'test_helper'

class AccessControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  def setup
    @controller = WelcomeController.new
  end

 test "should get index" do
   get :index, id: users(:userone)
   assert_response :success
 end

 test "should get login" do
   get :login
   assert_response :success
 end

end
