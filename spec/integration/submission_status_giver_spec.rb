require 'integration/integration_spec_helper'

describe 'Submission status transitions', js: true do

  let(:submission) { create :submission, author: author }
  let(:author) { create :author, access_id: 'authorflow' }

  before do
    basic_auth_and_visit root_path
  end

  describe "When status is 'collecting program information'" do
    before { submission.update_attribute :status, 'collecting program information' }

    context "visiting the 'Provide Program Information' page" do
      before { visit new_author_submission_path }
      specify "loads the page" do
        expect(current_path).to eq new_author_submission_path
      end
    end

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when I submit the 'Provide Program Information' form" do
      let!(:program) { create :program, name: 'Information Sciences and Technology' }
      let!(:degree) { create :degree, name: 'Master of Science' }
      before do
        visit new_author_submission_path
        fill_in 'Title', with: 'A unique test title'
        select program.name, from: 'Program'
        select degree.name, from: 'Degree'
        select 'Fall', from: 'Semester Intending to Graduate'
        select Time.zone.now.year.to_s, from: 'Graduation Year'
        click_button 'Save Program Information'
      end
      specify "submission status updates to 'collecting committee'" do
        new_submission = Submission.where(program: program, degree: degree, title: 'A unique test title').first
        expect(new_submission.status).to eq 'collecting committee'
      end
    end
  end

  describe "When status is 'collecting committee'" do
    before { submission.update_attribute :status, 'collecting committee' }

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq edit_author_submission_path(submission)
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq new_author_submission_committee_path(submission)
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when I submit the 'Provide Committee' form" do
      before do
        expect(submission.committee_provided_at).to be_nil
        visit new_author_submission_committee_path(submission)
        Committee.minimum_number_of_members.times do |i|
          fill_in "committee_committee_members_attributes_#{i}_name", with: "name_#{i}"
          fill_in "committee_committee_members_attributes_#{i}_email", with: "name_#{i}@example.com"
        end
        click_button 'Save Committee'
      end
      specify "submission status updates to 'collecting format review files'" do
        submission.reload
        expect(submission.status).to eq 'collecting format review files'
      end
      specify "submission committee_provided_at is set" do
        submission.reload
        expect(submission.committee_provided_at).to_not be_nil
      end
    end
  end

  describe "When status is 'collecting format review files'" do
    before { submission.update_attribute :status, 'collecting format review files' }

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq edit_author_submission_path(submission)
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq edit_author_submission_committee_path(submission)
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_edit_format_review_path(submission)
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when I submit the 'Upload Format Review Files' form" do
      before do
        expect(submission.format_review_files_uploaded_at).to be_nil
        visit author_submission_edit_format_review_path(submission)
        fill_in 'Title', with: 'Test Title'
        expect(page).to have_css '#format-review-file-fields .nested-fields:first-child input[type="file"]'
        first_input_id = first('#format-review-file-fields .nested-fields:first-child input[type="file"]')[:id]
        attach_file first_input_id, fixture('format_review_file_01.pdf')
        click_button 'Submit files for review'
      end
      specify "submission status updates to 'waiting for format review response'" do
        submission.reload
        expect(submission.status).to eq 'waiting for format review response'
      end
      specify "submission format_review_files_uploaded_at is set" do
        submission.reload
        expect(submission.format_review_files_uploaded_at).to_not be_nil
      end
    end
  end

  describe "When status is 'waiting for format review response'" do
    before { submission.update_attribute :status, 'waiting for format review response' }

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_program_information_path(submission)
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_committee_path(submission)
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_format_review_path(submission)
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when an admin accepts the format review files" do
      before do
        expect(submission.format_review_approved_at).to be_nil
        create :format_review_file, submission: submission
        visit admin_edit_submission_path(submission)
        fill_in 'Format Review Notes to Student', with: 'Note on format review'
        click_button 'Approve Format Review'
      end
      specify "submission status updates to 'collecting final submission files'" do
        submission.reload
        expect(submission.status).to eq 'collecting final submission files'
      end
      specify "submission format_review_approved_at is set" do
        submission.reload
        expect(submission.format_review_approved_at).to_not be_nil
      end
    end

    context "when an admin rejects the format review files" do
      before do
        expect(submission.format_review_rejected_at).to be_nil
        create :format_review_file, submission: submission
        visit admin_edit_submission_path(submission)
        fill_in 'Format Review Notes to Student', with: 'Note on need for revisions'
        click_button 'Reject & request revisions'
      end
      specify "submission status updates to 'collecting format review files'" do
        submission.reload
        expect(submission.status).to eq 'collecting format review files'
      end
      specify "submission format_review_rejected_at is set" do
        submission.reload
        expect(submission.format_review_rejected_at).to_not be_nil
      end
    end
  end

  describe "When status is 'collecting final submission files'" do
    before do
      submission.update_attribute :status, 'collecting final submission files'
      submission.update_attribute :format_review_notes, 'Format review note'
    end

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_program_information_path(submission)
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_committee_path(submission)
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_format_review_path(submission)
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_edit_final_submission_path(submission)
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when I submit the 'Upload Final Submission Files' form" do
      before do
        expect(submission.final_submission_files_uploaded_at).to be_nil
        visit author_submission_edit_final_submission_path(submission)
        select Time.zone.now.year, from: 'submission[defended_at(1i)]'
        select Time.zone.now.strftime('%B'), from: 'submission[defended_at(2i)]'
        select Time.zone.now.day, from: 'submission[defended_at(3i)]'
        fill_in 'Abstract', with: 'A paper on stuff'
        fill_in 'Keywords', with: 'stuff, more stuff'
        choose 'Open Access'
        expect(page).to have_css '#final-submission-file-fields .nested-fields:first-child input[type="file"]'
        first_input_id = first('#final-submission-file-fields .nested-fields:first-child input[type="file"]')[:id]
        attach_file first_input_id, fixture('final_submission_file_01.pdf')
        check 'I agree'
        click_button 'Submit final files for review'
      end
      specify "submission status updates to 'waiting for final submission response'" do
        submission.reload
        expect(submission.status).to eq 'waiting for final submission response'
      end
      specify "submission final_submission_files_uploaded_at is set" do
        submission.reload
        expect(submission.final_submission_files_uploaded_at).to_not be_nil
      end
    end
  end

  describe "When status is 'waiting for final submission response'" do
    before do
      submission.update_attribute :status, 'waiting for final submission response'
      submission.update_attribute :format_review_notes, 'Format review note'
    end

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_program_information_path(submission)
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_committee_path(submission)
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_format_review_path(submission)
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_final_submission_path(submission)
      end
    end

    context "when an admin accepts the final submission files" do
      let(:submission) { create :submission, :waiting_for_final_submission_response }
      before do
        expect(submission.final_submission_approved_at).to be_nil
        create :format_review_file, submission: submission
        create :final_submission_file, submission: submission
        visit admin_edit_submission_path(submission)
        fill_in 'Final Submission Notes to Student', with: 'Note on need for revisions'
        click_button 'Approve Final Submission'
      end
      specify "submission status updates to 'waiting for publication release'" do
        submission.reload
        expect(submission.status).to eq 'waiting for publication release'
      end
      specify "submission final_submission_approved_at is set" do
        submission.reload
        expect(submission.final_submission_approved_at).to_not be_nil
      end
    end

    context "when an admin rejects the final submission files" do
      let(:submission) { create :submission, :waiting_for_final_submission_response }
      before do
        expect(submission.final_submission_rejected_at).to be_nil
        create :format_review_file, submission: submission
        create :final_submission_file, submission: submission
        visit admin_edit_submission_path(submission)
        fill_in 'Final Submission Notes to Student', with: 'Note on need for revisions'
        click_button 'Reject & request revisions'
      end
      specify "submission status updates to 'collecting final submission files'" do
        submission.reload
        expect(submission.status).to eq 'collecting final submission files'
      end
      specify "submission final_submission_rejected_at is set" do
        submission.reload
        expect(submission.final_submission_rejected_at).to_not be_nil
      end
    end
  end

  describe "When status is 'waiting for publication release'" do
    before do
      submission.update_attribute :status, 'waiting for publication release'
    end

    context "visiting the 'Update Program Information' page" do
      before { visit edit_author_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Provide Committee' page" do
      before { visit new_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Update Committee' page" do
      before { visit edit_author_submission_committee_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Upload Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Program Information' page" do
      before { visit author_submission_program_information_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_program_information_path(submission)
      end
    end

    context "visiting the 'Review Committee' page" do
      before { visit author_submission_committee_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_committee_path(submission)
      end
    end

    context "visiting the 'Review Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_format_review_path(submission)
      end
    end

    context "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "visiting the 'Review Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_final_submission_path(submission)
      end
    end

    context "when an admin releases the submission for publication" do
      let(:submission) { create :submission, :waiting_for_publication_release }
      before do
        expect(submission.released_for_publication_at).to be_nil
        visit admin_submissions_index_path(Degree.default_degree_type, 'final_submission_approved')
        click_button 'Select All'
        expect(page).to have_button 'Release selected for publication'
        click_button 'Release selected for publication'
      end
      specify "submission status updates to 'released for publication'" do
        submission.reload
        expect(submission.status).to eq 'released for publication'
      end
      specify "submission released_for_publication_at is set" do
        submission.reload
        expect(submission.released_for_publication_at).to_not be_nil
      end
    end
  end

end
