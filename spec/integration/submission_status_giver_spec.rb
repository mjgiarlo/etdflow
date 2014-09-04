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

    context "visiting the 'Provide Format Review Files' page" do
      before { visit author_submission_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "visiting the 'Update Format Review Files' page" do
      before { visit author_submission_edit_format_review_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "visiting the 'Provide Final Submission Files' page" do
      before { visit author_submission_final_submission_path(submission) }
      specify "raises a forbidden access error" do
        expect(page).to have_content 'You are not allowed to visit that page at this time, please contact your administrator'
        expect(current_path).to eq author_root_path
      end
    end

    pending "visiting the 'Update Final Submission Files' page" do
      before { visit author_submission_edit_final_submission_path(submission) }
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
end
