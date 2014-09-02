require 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
    # Use truncation so that other processes (e.g. phantomjs) see the same thing 
    DatabaseCleaner.strategy = :truncation
    # But use truncation to start the suite with an empty database.
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    # Begin transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    # Roll back transaction
    DatabaseCleaner.clean
  end

end
