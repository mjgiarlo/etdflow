require 'integration/integration_spec_helper'

describe "The root path" do

  before do
    visit root_path
  end

  specify "Displays the current Rails environment" do
    page.should have_content "test environment"
  end

end
