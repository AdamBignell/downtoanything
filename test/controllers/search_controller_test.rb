require 'test_helper'

class SearchControllerTest < ActionController::TestCase

# The below lines fix the Devise 'could not find 'Warden:Proxy'' error
  include Devise::TestHelpers                          
  include Warden::Test::Helpers                        
  Warden.test_mode!                                    

  def teardown                                         
    Warden.test_reset!                                 
  end

  setup do
    sign_in users(:userone)
  end

  test "should get results" do
    get :results
    assert_response :success
  end

end
