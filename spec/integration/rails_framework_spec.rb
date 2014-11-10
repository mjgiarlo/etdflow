require 'integration/integration_spec_helper'

describe "The root path" do

  let(:author) { create :author }

  before do
    basic_auth_and_visit root_path
  end

  specify "Displays the current Rails environment" do
    page.should have_content "test environment"
  end

  specify "Header should contain the authenticated author's name" do
    page.should have_content "Logged in as Joseph Quicny Example"
  end

end
