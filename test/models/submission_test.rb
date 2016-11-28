require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase

  test "submission created properly" do
    s = Submission.create()
  	s.save
  	assert_not_nil(s, "Submissions are not properly created!")
  	end
end
