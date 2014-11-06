require 'integration/integration_spec_helper'

describe "The root path" do

  let(:author) { create :author, access_id: 'authorflow' }

  before do
    basic_auth_and_visit root_path
  end

  specify "Displays the current Rails environment" do
    page.should have_content "test environment"
  end

end
