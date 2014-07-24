RSpec.configure do |config|
  config.before do
    # Clear all mock format review data.
    MockFormatReview.saved_files.clear
  end 
end
