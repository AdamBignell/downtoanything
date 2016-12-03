require 'test_helper'

class SearchResultsTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:userone)
		@challenge = challenges(:one)
		@fixture = us_chal_interactions(:fixone)
		@challenge.us_chal_interactions << @fixture
		@challenges = [@challenge]
	end

	test "can we see results" do
		post user_session_path, 'user[email]' => @user.email, 'user[password]' =>  'gelitripping'
		get "/search/results"
		assert_response :success
	end

	test "are both tables present" do
		post user_session_path, 'user[email]' => @user.email, 'user[password]' =>  'gelitripping'
		get "/search/results"
		assert_select "table", 2
	end

	test "actually search for user" do
		post user_session_path, 'user[email]' => @user.email, 'user[password]' =>  'gelitripping'
		get "/search/results"
		fill_in('searchform', with: "tommy")
		click_button('searchbutton')
		assert_response :success
	end
end