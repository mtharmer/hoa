# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.6'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.5', '>= 7.1.5.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'brakeman', '~> 7.0'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'bundle-audit', '~> 0.1.0'
  gem 'capybara', '~> 3.40'
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails', '~> 6.5'
  gem 'reek', '~> 6.5'
  gem 'rspec-rails', '~> 7.1'
  gem 'rubocop-capybara', '~> 2.22'
  gem 'rubocop-erb', '~> 0.6.0'
  gem 'rubocop-factory_bot', '~> 2.27'
  gem 'rubocop-rails', '~> 2.32'
  gem 'rubocop-rake', '~> 0.7.1'
  gem 'rubocop-rspec', '~> 3.6'
  gem 'rubocop-rspec_rails', '~> 2.31'
  gem 'rubycritic', '~> 4.9'
  gem 'selenium-webdriver', '~> 4.34'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'climate_control', '~> 1.2'
  gem 'database_cleaner-active_record', '~> 2.2'
  gem 'faker', '~> 3.5'
  gem 'shoulda-matchers', '~> 6.5'
  gem 'simplecov', '~> 0.22.0'
end

gem 'aws-actionmailer-ses', '~> 1.0'
gem 'aws-sdk-rails', '~> 5.1'
gem 'aws-sdk-s3', '~> 1.192'
gem 'devise', '~> 4.9'
gem 'image_processing', '~> 1.14'
gem 'pagy', '~> 9.3'
gem 'rack-attack', '~> 6.7'
