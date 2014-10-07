require_relative 'system_spec_helper'

describe 'On the deployed application', type: :system do

  specify "I can see the public home page" do
    require 'base64'
    page.driver.headers = {'Authorization' => 'Basic '+ Base64.encode64('etdflow:fold wet')};
    visit '/'
    page.should have_content "production environment"
  end

end
