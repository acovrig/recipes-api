source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# UI Framework
gem 'bootstrap-sass', '~> 3.4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Don't hardcode paths, even in js
gem 'js-routes', '~> 1.4.14'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# auth
gem 'devise', '~> 4.7.3'
# api auth
gem 'devise_token_auth', '~> 1.1.5'
# Pinned at this version as devise currently fails unless OmniAuth::VERSION ~= /^1\./
# see https://github.com/heartcombo/devise/blob/4-1-stable/lib/devise/omniauth.rb#L9
gem 'omniauth', '1.9.1'
# facebook auth (do I actually use this?)
gem 'omniauth-facebook', '~> 8.0.0'
# google auth
gem 'omniauth-google-oauth2', '~> 0.8.2'

# pretty console
gem 'pry', '~> 0.14.1'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Allow API access
gem 'rack-cors', require: 'rack/cors' # rubocop:disable Bundler/GemVersion
# pagination (for recipe#index and category#index/show)
gem 'will_paginate', '~> 3.3.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# image processing (thmbnails)
gem 'mini_magick', '~> 4.11.0'

# ERB linter
gem 'erb_lint', '~> 0.0.37'
# Ruby linter
gem 'rubocop', '~> 1.14.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # rubocop:disable Bundler/GemVersion
  # Generate fake records for testing
  gem 'factory_bot_rails', '~> 6.1.0'
  # Fake data pool
  gem 'faker', '~> 2.17.0'
  # Test framework
  gem 'rspec-rails', '~> 5.0.1'
  # Browser control for tests
  gem 'selenium-webdriver', '~> 3.142.7'
  # Test coverage metrics?
  gem 'simplecov', '~> 0.21.2'
end

group :development do
  # Debugging?
  gem 'listen', '~> 3.3'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rails_real_favicon', '~> 0.1.0' # <%= render 'application/favicon' %> # Edit config/favicon.json and set master_picture to app-root relative path, then run rails generate favicon to generate it
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.1.1'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 4.6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby] # rubocop:disable Bundler/GemVersion
