ENV['RAILS_ENV'] ||= 'test'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'support/database_cleaner'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include Devise::TestHelpers
end

def with_versioning
  was_enabled = PaperTrail.enabled?
  was_enabled_for_controller = PaperTrail.enabled_for_controller?
  PaperTrail.enabled = true
  PaperTrail.enabled_for_controller = true
  begin
    yield
  ensure
    PaperTrail.enabled = was_enabled
    PaperTrail.enabled_for_controller = was_enabled_for_controller
  end
end
