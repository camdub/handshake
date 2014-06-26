require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] = 'test'

require 'dotenv'
Dotenv.load

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
end

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'vcr_cassettes')
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
   c.syntax = :expect
  end

  config.include Features, type: :feature
  config.color = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
