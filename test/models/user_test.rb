require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "password is hashed" do
  	u = User.create(email: 'thomas@pynchon.ca', username: 'tommyp', points: 0, team_id: 1, password: 'slothrop', admin: true)
	  u.save
	  assert_not_equal(u.password, u.encrypted_password, "The password was not properly encrypted!")
	end


  test "user created properly" do
  	u2 = User.create(email: 'dave@wallace.com', username: 'DFW', points: 0, team_id: 1, password: 'enfieldtennis', admin: true)
	  u2.save
	  assert_not_nil(u2, "Users are not properly created!")
	end

  test 'no email' do
    user = User.new(username: "BadGuy")
    refute user.valid?
    assert_not_nil user.errors
  end

  test 'no username' do
    user = User.new(email: "joe@example.com")
    refute user.valid?
    assert_not_nil user.errors
  end

  test 'unique username' do
    user1 = User.new(username: "joe", email: "joe@example.com")
    user2 = User.new(username: "joe", email: "joe2@example.com")
    refute user2.valid?
    assert_not_nil user2.errors
  end

  test 'unique email' do
    user1 = User.new(username: "joe", email: "joe@example.com")
    user2 = User.new(username: "joe2", email: "joe@example.com")
    refute user2.valid?
    assert_not_nil user2.errors
  end
end
