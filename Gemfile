source 'https://rubygems.org'

ruby IO.read('.ruby-version').strip

gem 'rails', '4.2.11.1'
gem 'sinatra', require: nil

gem 'foreman'
gem 'puma'

gem 'kaminari', '~> 0.16.3'
gem 'bootstrap-kaminari-views', '0.0.5'

gem 'alphabetical_paginate', '2.2.3'
gem 'pg', '~> 0.18'
gem 'govuk_admin_template', '4.2.0'
gem 'deprecated_columns', '0.1.0'

gem 'rails-html-sanitizer', '1.0.3'

# This change was made via Snyk to fix a vulnerability
gem 'nokogiri', '>= 1.7.0.1'

gem 'bugsnag'
gem 'json'
gem 'addressable', '~> 2.3.8'

gem 'newrelic_rpm'
gem 'plek', '1.7.0'
gem 'whenever', '~> 0.9.4', require: false

gem 'uuid'

# Gems used to provide Authentication and Authorization services.
# This change was made via Snyk to fix a vulnerability
gem 'devise', '>= 4.2.0'
gem 'devise_invitable', '1.7.0'
gem 'devise-encryptable', '0.2.0'
gem 'devise_zxcvbn', '1.1.1'
gem 'pundit', '0.3.0'
gem 'rotp', '~> 2.1.1'
gem 'rqrcode'

# This change was made via Snyk to fix a vulnerability
gem 'doorkeeper', '>= 4.2.0'
gem 'ancestry', '2.0.0'

gem 'gds-api-adapters', '20.1.1'
gem 'statsd-ruby', '1.1.0'
gem 'sidekiq', '~> 4.1.0'
gem 'activejob-retry'

gem 'redis'
gem 'redis-namespace'

gem 'zeroclipboard-rails'

gem 'rake', '10.4.1'

gem 'sass-rails', '~> 5.0.6'
gem 'sprockets-rails', '~> 3.1.1'

# This change was made via Snyk to fix a vulnerability
gem 'uglifier', '>= 3.0.4'

group :development do
  gem 'quiet_assets', '1.0.2'
  gem 'better_errors', '2.1.1'
  gem 'binding_of_caller', '0.7.2'
end

group :development, :test do
  gem 'jasmine', '2.5.1'
  gem 'govuk-lint', '~> 0.4'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec-rails', '~> 3.3.3'
  gem 'capybara', '~> 2.5.0'
  gem 'capybara-email', '~> 2.4.0'
  gem 'poltergeist', '1.6.0'
  gem 'database_cleaner', '1.5.0'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'mocha', '1.1.0', require: false
  gem 'webmock'
  gem 'minitest', '~> 5.8.0'
  gem 'ci_reporter', '1.7.0'
  gem 'timecop', '0.7.1'
  gem 'shoulda-context', '1.2.1', require: false
  gem 'test_after_commit'
  gem 'phantomjs-binaries'
end

group :staging, :production do
  gem 'rails_12factor'
end
