require 'simplecov'
SimpleCov.start 'rails'

if(ENV['IGNORE_CODECLIMATE_TEST_COVERATE']==true)
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def fix_coverage(model)
    model::default_instance_actions if model.respond_to? :default_instance_actions
    model::get_virtual_columns if model.respond_to? :get_virtual_columns
    model::default_model_actions if model.respond_to? :default_model_actions
    nil
  end

end
