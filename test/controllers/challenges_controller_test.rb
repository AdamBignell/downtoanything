require 'test_helper'

class ChallengesControllerTest < ActionController::TestCase

  # The below lines fix the Devise 'could not find 'Warden:Proxy'' error
  include Devise::Test::ControllerHelpers
  # include Devise::TestHelpers                          
  # include Warden::Test::Helpers                        
  # Warden.test_mode!                                    

  # def teardown                                         
  #   Warden.test_reset!                                 
  # end

  setup do
    @request.env['devise.mapping'] = Devise.mappings[:challenge]
    @challenge = Challenge.first
    @challenge.save!
    User.first.skip_confirmation!
    sign_in User.first
  end


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:challenges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create challenge" do
    assert_difference('Challenge.count') do
      post :create, challenge: { name: @challenge.name, score: @challenge.score, user_id: @challenge.user_id }
    end

    assert_redirected_to challenge_path(assigns(:challenge))
  end

  test "should show challenge" do
    get :show, id: @challenge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @challenge
    assert_response :success
  end

  test "should update challenge" do
    patch :update, id: @challenge, challenge: { name: @challenge.name, score: @challenge.score, user_id: @challenge.user_id }
    assert_redirected_to challenge_path(assigns(:challenge))
  end

  test "should destroy challenge" do
    assert_difference('Challenge.count', -1) do
      delete :destroy, id: @challenge
    end

    assert_redirected_to challenges_path
  end
end
