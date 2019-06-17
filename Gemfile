# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

gem 'apipie-rails'
gem 'dotenv-rails'
gem 'fast_jsonapi'
gem 'geocoder'

gem 'devise-jwt'
gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

group :development do
  gem 'google_places'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'seed_dump'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
