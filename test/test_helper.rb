ActiveRecord::Migration.maintain_test_schema!

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  config.include Capybara::DSL
  #include Devise::Test::ControllerHelpers

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  def self.context *args, &block
    super *args do
      setup do
        # establish the rails controller being tested
        # https://github.com/citrusbyte/contest/issues/5#issuecomment-677003
        ancestors = self.class.ancestors
        test_case = ancestors[ancestors.index(ActionController::TestCase) - 1]
        @controller = test_case.controller_class.new
      end
      class_eval &block
    end
  end
end
