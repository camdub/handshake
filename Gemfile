source 'https://rubygems.org'

ruby '2.1.1'

gem 'delayed_job_active_record'
gem 'email_validator'
gem 'pg'
gem 'rack-timeout'
gem 'rails', '~> 4.1.0'
gem 'recipient_interceptor'
gem 'puma'
gem 'grape'
gem 'grape-entity'
gem 'devise'
gem 'hashie_rails'
gem 'redis'
gem 'linkedin2', git: 'https://github.com/camdub/linkedin2.git'
gem 'virtus'
gem 'grape-swagger'
gem 'mock_redis'

group :development do
  gem 'foreman'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '>= 2.14'
  gem 'byebug'
  gem 'pry-byebug', github: 'deivid-rodriguez/pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-rescue'
  gem 'vcr'
  gem 'webmock'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'json-schema'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.7.3'
  gem 'rails_stdout_logging'
end
