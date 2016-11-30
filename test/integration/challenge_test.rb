require 'test_helper'

class ChallengeTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can create a challenge" do
    get "/challenges/new"
    assert_response :success
  
    post "/challenges",
      params: { challenge: { title: "Test Challenge", description: "Do some crazy stuff." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span", "Test Challenge"
  end

  test 

  test "can edit a challenge" do
    get "/challenges/1/edit"
    assert_response :success
  
    patch "/challenges/1",
      params: { challenge: { title: "Test Challenge", description: "Do some more crazy stuff." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span", "Do some more crazy stuff."
  end

  test "can delete a challenge" do
    get "/challenges/1/edit"
    assert_response :success
  
    patch "/challenges/1",
      params: { challenge: { title: "Test Challenge", description: "Do some more crazy stuff." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span", "Do some more crazy stuff."
  end

end
