RSpec.configure do |config|
  config.before do
    # Clear all mock format review data.
    MockDepositor.saved_files.clear
  end 
end
