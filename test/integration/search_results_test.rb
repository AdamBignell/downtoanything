require 'test_helper'

class SearchResultsTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:userone)
	end

	test "can we see results" do
		post user_session_path, 'user[email]' => @user.email, 'user[password]' =>  'gelitripping'
		get "/search/results"
		assert_response :success
	end
end