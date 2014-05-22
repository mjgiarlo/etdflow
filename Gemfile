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

# Core repository software stack
gem 'hydra'

# Authentication
gem "devise"

# Added by hydra generator
gem "devise-guests", "~> 0.3"

group :development do

  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'

  # Deploy to multiple environments
  gem 'capistrano-ext'

  # Useful recipes for generalizing deployment behavior
  gem 'capistrano-helpers'

end

group :test do

  # human readable acceptance test framework
  gem 'cucumber'

  # DSL for browser-based testing
  gem 'capybara'

  # PhantomJS driver for capybara
  gem 'poltergeist'

  # See what your headless browser is seeing with save_and_open_page
  gem 'launchy'

end

group :development, :test do

  # core testing framework for rails
  gem "rspec-rails"

  # Solr and fedora development environment
  gem "jettywrapper"

end
