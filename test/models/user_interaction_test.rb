require 'test_helper'

class UserInteractionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "must have interaction set" do
    ui = UserInteraction.new(:user_id => 1, :submission_id => 1)
    refute ui.valid?
    assert_includes(ui.errors.full_messages, "Interaction can't be blank")
  end

  test "must belong to user and interaction" do
    ui = UserInteraction.new(:interaction => "liked")
    refute ui.valid?
    assert_includes(ui.errors.full_messages, "User can't be blank")
    assert_includes(ui.errors.full_messages, "Submission can't be blank")
  end

  test "must have correct interaction name" do
    ui = UserInteraction.new(:interaction => "wants to draw a picture of", :user_id => 1, :submission_id => 1)
    refute ui.valid?
    assert_includes(ui.errors.full_messages, "Interaction must be one of: created, liked, disliked, neutral")    
  end

end
