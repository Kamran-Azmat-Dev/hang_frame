source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.6'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'spree_paypal_express', github: 'spree-contrib/better_spree_paypal_express'
gem 'paypal-sdk-rest'
gem 'certified', '~> 1.0'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false

gem 'dry-validation'
gem 'dotenv'

gem 'spree', '~> 4.2'
gem 'spree_auth_devise', '~> 4.3'
gem 'spree_gateway', '~> 3.9'
gem 'spree_i18n', '~> 5.0'

gem 'spree_google_analytics', github: 'upsidelab/spree_google_analytics', ref: '33bf17d'
gem 'spree_editor', github: 'spree-contrib/spree_editor'

gem 'sidekiq', '~> 6.2'
gem 'dalli', '~> 2.7'
gem "paperclip", "~> 6.0.0"
gem 'aws-sdk-rails', '~> 3'
gem 'aws-sdk-s3', '~> 1'

gem 'sentry-ruby'
gem 'sentry-rails'

gem 'klaviyo'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'rubocop', '~> 1.12', require: false
  gem 'ffaker'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
