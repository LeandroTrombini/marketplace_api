# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.0'
gem 'bootsnap', require: false
gem 'devise', '~> 4.9', '>= 4.9.2'
gem 'multi_json'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.1.2'
gem 'rswag-api'
gem 'rswag-ui'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'ffaker', '~> 2.21'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'rswag-specs', '~> 2.10', '>= 2.10.1'
  gem 'rubocop', '~> 1.54', '>= 1.54.2', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.22.0', require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
