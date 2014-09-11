require 'integration/integration_spec_helper'

describe 'Submission status transitions', js: true do

  let(:submission) { create :submission, author: author }
  let(:author) { create :author, access_id: "etdflow" }

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
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "visiting the 'Upload Final Submission Files' page" do
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
        select program.name, from: 'Program'
        select degree.name, from: 'Degree'
        select 'Fall', from: 'Semester Intending to Graduate'
        select Time.zone.now.year.to_s, from: 'Graduation Year'
        click_button 'Save Program Information'
      end
      specify "submission status updates to 'collecting committee'" do
        new_submission = Submission.where(program: program, degree: degree).first
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
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when I submit the 'Provide Committee' form" do
      before do
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
      before { visit author_submission_format_review_path(submission) }
      specify "loads the page" do
        expect(current_path).to eq author_submission_format_review_path(submission)
      end
    end

    pending "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    context "when I submit the 'Upload Format Review Files' form" do
      before do
        visit author_submission_format_review_path(submission)
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
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "visiting the 'Upload Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "when an admin rejects the format review files" do
      before do
      end
      specify "submission status updates to 'collecting format review files'" do
        submission.reload
        expect(submission.status).to eq 'collecting format review files'
      end
    end

    pending "when an admin accepts the format review files" do
      before do
      end
      specify "submission status updates to 'collecting final submission files'" do
        submission.reload
        expect(submission.status).to eq 'collecting final submission files'
      end
    end
  end

end