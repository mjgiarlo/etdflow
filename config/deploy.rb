require 'bundler/capistrano'            # Use bundler on remote server
require 'capistrano/ext/multistage'     # Support for multiple deploy targets
require 'capistrano-helpers/branch'     # Ask user what tag to deploy
require 'capistrano-helpers/passenger'  # Support for Apache passenger
require 'capistrano-helpers/git'        # Support for git
require 'capistrano-helpers/shared'     # Symlink shared files after deploying
require 'capistrano-helpers/migrations' # Run all migrations automatically

# Location of the source code.
set :repository,  'git@github.com:westarete/etdflow.git'

# Our setup does not require or allow sudo.
set :use_sudo, false

# The remote user to log in as.
set :user, 'deploy'

# Set the files that should be replaced with their private counterparts.
set :shared, %w{ 
  config/database.yml
  config/secrets.yml
}
