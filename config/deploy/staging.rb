# The directory that we're deploying to on the remote host.
set :deploy_to, "/var/www/sites/staging.etdflow.com"

# Tell capistrano to use the staging environment. This is key for running 
# the database migrations via "cap staging deploy:migrations".
set :rails_env, "staging"

# The hosts that we're deploying to.
role :app, "etdflow.westarete.com"
role :web, "etdflow.westarete.com"
role :db,  "etdflow.westarete.com", :primary => true
