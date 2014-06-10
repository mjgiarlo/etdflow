# The directory that we're deploying to on the remote host.
set :deploy_to, "/var/www/sites/production.etdflow.westarete.com"

# Tell capistrano to use the staging environment. This is key for running 
# the database migrations via "cap staging deploy:migrations".
set :rails_env, "production"

# The hosts that we're deploying to.
role :app, "production.etdflow.westarete.com"
role :web, "production.etdflow.westarete.com"
role :db,  "production.etdflow.westarete.com", :primary => true