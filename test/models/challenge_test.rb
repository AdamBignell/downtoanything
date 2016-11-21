require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase

test "challenge created properly" do
  	c = Challenge.create(name: 'Say Alphabet Backwards', description: 'Recite the alphabet from Z to A')
	c.save
	assert_not_nil(c, "Challenges are not properly created!")
	end
end
