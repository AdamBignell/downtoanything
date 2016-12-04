require 'test_helper'

class UsChalInteractionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "must have interaction set" do
    ui = UsChalInteraction.new
    refute ui.valid?
    assert_not_nil ui.errors
  end
end
