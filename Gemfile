source 'https://rubygems.org'


# web framework
gem 'rails', '~> 4.1.0'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Provide a Javascript runtime for ExecJS 
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# core institutional repository platform
# temporarily pointing to their github repo
# see: https://github.com/curationexperts/worthwhile/issues/10
gem 'worthwhile', github: 'curationexperts/worthwhile' 

# Authentication
gem 'devise'

# Form builder
gem 'simple_form', '3.1.0.rc1'

# Ruby templating system for generating JSON
gem 'rabl'

# File uploads
gem 'carrierwave'

# For image resizing
gem 'mini_magick'

# Easily handle nested forms
gem 'cocoon'

# FontAwesome sass integration
gem 'font-awesome-sass'

group :development do

  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'

  # Deploy to multiple environments
  gem 'capistrano-ext'

  # rbenv support for capistrano
  gem 'capistrano-rbenv'

  # Mention deployment on IRC
  gem 'capistrano-notification'

  # Used to seed the development database
  gem 'ffaker'

end

group :test do

  # human readable acceptance test framework
  gem 'cucumber-rails', :require => false

  # DSL for browser-based testing
  gem 'capybara'

  # PhantomJS driver for capybara
  gem 'poltergeist'

  # See what your headless browser is seeing with save_and_open_page
  gem 'launchy'

  # Clean out database between test runs
  gem 'database_cleaner'

  # Helpful RSpec matchers for rails
  gem 'shoulda-matchers'

end

group :development, :test do

  # core testing framework for rails
  gem 'rspec-rails'
  
  # Solr and fedora development environment
  gem 'jettywrapper'
  
  # Test object factory
  gem 'factory_girl_rails'

end

