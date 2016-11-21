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
    assert_not_nil user.errors[:email]
  end
end
