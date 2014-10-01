source 'https://rubygems.org'


# web framework
gem 'rails', '~> 4.1.0'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

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

# Core institutional repository platform
gem 'worthwhile', github: 'curationexperts/worthwhile' # Use master, even if it hasn't been released yet
gem 'devise' # Referenced by worthwhile, but not used by this app

# Form builder
gem 'simple_form'

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

# Add and remove foreign key constraints
gem 'foreigner'

# Foreigner migration generator
gem 'immigrant'

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

  # Must be required before jettywrapper for tests to run in RubyMine
  gem 'rake'

  # Solr and fedora development environment
  gem 'jettywrapper'
  
  # Test object factory
  gem 'factory_girl_rails'

end

