require_relative 'system_spec_helper'

describe 'On the deployed application', type: :system do

  specify "I can see the public home page" do
    visit '/'
    page.should have_content "staging environment"
  end

end