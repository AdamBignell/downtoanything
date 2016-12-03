require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	test 'has user_id' do
		comment = Comment.new(bodytext: 'Toil and Trouble')
		refute comment.valid?
		assert_not_nil comment.errors[:user_id]		
	end
end
