# The directory that we're deploying to on the remote host.
set :deploy_to, "/var/www/sites/beta.etdflow.westarete.com"

# Tell capistrano to use the staging environment. This is key for running 
# the database migrations via "cap staging deploy:migrations".
set :rails_env, "beta"

# The hosts that we're deploying to.
role :app, "beta.etdflow.westarete.com"
role :web, "beta.etdflow.westarete.com"
role :db,  "beta.etdflow.westarete.com", :primary => true
