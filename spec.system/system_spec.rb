require_relative 'system_spec_helper'

describe 'On the deployed application', type: :system do

  context "When I'm logged in with HTTP basic" do
    before do
#      page.driver.basic_authorize('etdflow', 'fold wet')
      author = Author.new(access_id: 'etdflow', psu_email_address: 'etdflow@psu.edu', id:1)
      sign_in_as author
    end

    specify "I can see my submissions" do
      visit '/'
      click_link "Submissions"
      expect(page).to have_content "Title of a Thesis"
    end
  end

end
