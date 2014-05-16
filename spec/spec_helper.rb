# This is the most general RSpec configuration for the project.
#
# This file should only contain spec setup code that is common to all types
# of specs. In particular, it should *not* load Rails or the database, since
# that would add that overhead to the lightweight tests in the suite.

RSpec.configure do |config|
  # Anticipate future default behavior (and silence warnings)
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

# Define the root of the project (for specs that don't load Rails).
ROOT = Pathname.new(File.expand_path(File.dirname(__FILE__) + '/..'))

