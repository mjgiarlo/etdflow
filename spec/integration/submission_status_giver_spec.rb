require 'integration/integration_spec_helper'

describe 'Submission status transitions', js: true do

  let(:submission) { create :submission }

  before do
    basic_auth_and_visit root_path
  end

  describe "When status is 'collecting program information'" do
    before { submission.update_attribute :status, 'collecting program information' }

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "submission status updates to 'collecting committee'" do
        submission.reload
        expect(submission.status).to eq 'collecting committee'
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      context 'when there is a committee' do
        before do
          create_committee(submission) 
          visit author_submission_format_review_path(submission)
        end
        specify "submission status updates to 'collecting format review files'" do
          submission.reload
          expect(submission.status).to eq 'collecting format review files'
        end
      end
      context 'when there is no committee' do
        before do
          visit author_submission_format_review_path(submission)
        end
        specify "submission status remains 'collecting program information'" do
          submission.reload
          expect(submission.status).to eq 'collecting program information'
        end
      end
    end
  end

  describe "When status is 'collecting committee'" do
    before { submission.update_attribute :status, 'collecting committee' }

    context "visiting the 'Upload Format Review Files' page" do
      context 'when there is a committee' do
        before do
          create_committee(submission) 
          visit author_submission_format_review_path(submission)
        end
        specify "submission status updates to 'collecting format review files'" do
          submission.reload
          expect(submission.status).to eq 'collecting format review files'
        end
      end
      context 'when there is no committee' do
        before do
          visit author_submission_format_review_path(submission)
        end
        specify "submission status remains 'collecting committee'" do
          submission.reload
          expect(submission.status).to eq 'collecting committee'
        end
        specify "the current page should be the 'My Submissions' page" do
          expect(current_path).to eq author_root_path
        end
      end
    end

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "submission status updates to 'collecting program information'" do
        submission.reload
        expect(submission.status).to eq 'collecting program information'
      end
    end

  end

  describe "When status is 'collecting format review files'" do
    before do
      submission.update_attribute :status, 'collecting format review files'
      create_committee(submission)
    end

    context "submitting the 'Upload Format Review Files' form" do
      before do
        visit author_submission_format_review_path(submission)
        expect(page).to have_css '#format-review-file-fields .nested-fields:first-child input[type="file"]'
        first_input_id = first('#format-review-file-fields .nested-fields:first-child input[type="file"]')[:id]
        attach_file first_input_id, fixture('format_review_file_01.pdf')
        click_button 'Submit files for review'
      end
      specify "submission status updates to 'waiting for format review response'" do
        submission.reload
        expect(submission.status).to eq 'waiting for format review response'
      end
    end

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "submission status updates to 'collecting program information'" do
        submission.reload
        expect(submission.status).to eq 'collecting program information'
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "submission status updates to 'collecting committee'" do
        submission.reload
        expect(submission.status).to eq 'collecting committee'
      end
    end
  end
end
