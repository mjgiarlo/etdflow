require 'integration/integration_spec_helper'

describe 'Committee Search Modal', js: true do

  let(:submission) { create :submission, author: author }
  let(:author) { create :author, access_id: 'authorflow' }

  before do
    basic_auth_and_visit root_path
  end
  before { submission.update_attribute :status, 'collecting committee' }
  before do
    visit new_author_submission_committee_path(submission)
  end

  describe "When status is 'collecting committee'" do

    context "visiting the 'Provide Committee' page" do
      specify "committee search button is visible" do
        expect(page).to have_link("Search Penn State Directory")
      end
    end

    context "Open the Committee Search Modal" do
      before { click_button "Search Penn State Directory" }

      specify "header is visible" do
        expect(page).to have_content 'Penn State Directory Search for Committee Members'
        end
      specify "search form is displayed" do
        expect(page).to have_content 'Please specify either a single Access Account ID or a single last name and click Search.'
      end

      context "perform successful search and selection"  do
        before do
          LdapLookup.any_instance.stub(:get_ldap_list).and_return(mock_ldap_list)
        end

        specify "fill in last name" do
          fill_in 'ldap_lookup_info_uid', with: 'barnoff'
          find(:xpath, "//input[@value ='Search']").click

          expect(page).to have_content('Select committee member')
          expect(page).to have_content('Richard M Barnoff')
          choose('search_for_committee_radio_1')
          select('Advisor', from: 'search_committee_role_list')
          find(:xpath, "//input[@value = 'Add Committee Member']").click

          expect(page).to have_content('Committee Member was added.')
          end
      end

      context "unsuccessful search and selection should display an error message"  do
        before do
          LdapLookup.any_instance.stub(:get_ldap_list).and_return(mock_ldap_list)
        end

        specify "fill in last name" do
          fill_in 'ldap_lookup_info_uid', with: 'barnoff'
          find(:xpath, "//input[@value ='Search']").click

          expect(page).to have_content('Select committee member')
          expect(page).to have_content('Richard M Barnoff')
          select('Advisor', from: 'search_committee_role_list')
          find(:xpath, "//input[@value = 'Add Committee Member']").click

          expect(page).to have_content('Please select a committee member and committee member role')
        end
      end
    end
  end
end






