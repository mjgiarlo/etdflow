require 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
    # In general, use transactions to clean database (fast).
    DatabaseCleaner.strategy = :transaction
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