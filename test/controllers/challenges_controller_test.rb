require 'test_helper'

class ChallengesControllerTest < ActionController::TestCase

  # The below lines fix the Devise 'could not find 'Warden:Proxy'' error
  include Devise::Test::ControllerHelpers
  include Devise::TestHelpers                          
  include Warden::Test::Helpers                        
  Warden.test_mode!                                    

  def teardown                                         
    Warden.test_reset!                                 
  end

  setup do
    @challenge = challenges(:one)
    @challenge.save!
  end

  test "should show challenges" do
    sign_in User.first
    get :index
    Challenge.all.each do |challenge|
      assert_select "span", challenge.name
    end
  end

  test "should get index" do
    sign_in User.first
    get :index
    assert_response :success
    assert_not_nil assigns(:challenges)
  end

  test "should get new" do
    @request.env['devise.mapping'] = Devise.mappings[:challenge]
    sign_in User.first
    get :new
    assert_response :success
  end

  test "should create challenge" do
    sign_in User.first
    assert_difference('Challenge.count') do
      post :create, challenge: { name: @challenge.name, score: @challenge.score, user_id: @challenge.user_id }
    end

    assert_redirected_to challenge_path(assigns(:challenge))
  end

  test "should show challenge" do
    sign_in User.first
    get :show, id: @challenge
    assert_response :success
  end

  test "should get edit" do
    sign_in User.first
    get :edit, id: @challenge
    assert_response :success
  end

  test "should update challenge" do
    sign_in User.first
    patch :update, id: @challenge, challenge: { name: @challenge.name, score: @challenge.score, user_id: @challenge.user_id }
    assert_redirected_to challenge_path(assigns(:challenge))
  end

  test "should destroy challenge" do
    sign_in User.first
    assert_difference('Challenge.count', -1) do
      delete :destroy, id: @challenge
    end

    assert_redirected_to challenges_path
  end
end
