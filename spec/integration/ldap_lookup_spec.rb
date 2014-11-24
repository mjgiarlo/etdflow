require 'integration/integration_spec_helper'

describe 'Submission status transitions', js: true do

  let(:submission) { create :submission, author: author }
  let(:author) { create :author, access_id: 'authorflow' }

  before do
    basic_auth_and_visit root_path
  end

  describe "When status is 'collecting committee'" do
    before { submission.update_attribute :status, 'collecting committee' }

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
        specify "loads the page" do
          expect(current_path).to eq new_author_submission_committee_path(submission)
        end
        specify "search button is visible" do
          expect(page).to have_link("Search Penn State Directory")
        end


      context "opening the Committee Search Modal" do

          before { click_button "Search Penn State Directory" }
          specify "header is visible" do
            expect(page).to have_content 'Penn State Directory Search for Committee Members'
          end
          specify "search form is displayed" do
            expect(page).to have_content 'Please specify either a single Access Account ID or a single last name and click Search.'
          end
          specify "input access id" do
            fill_in 'ldap_lookup_info_uid', with: 'jxb13'
          end
          specify "submit search form" do
            click_button "Search" do
              expect(page).to have_content('Select committee member')
            end
          end
        end
      end
    end
  end


