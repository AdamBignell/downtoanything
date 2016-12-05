require 'test_helper'

class AccessControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers                         
  include Warden::Test::Helpers                        
  Warden.test_mode!  

 test "should get index" do
   get :index
   assert_response :success
 end

 test "should get login" do
   get :login
   assert_response :success
 end

end
