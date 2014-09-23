require 'component/presenters/component_presenters_spec_helper'

describe Admin::SubmissionFormView do

  let(:view) { Admin::SubmissionFormView.new submission }
  let(:submission) { create :submission }

  describe '#title' do
    context "When the status is before 'waiting for format review response'" do
      before { submission.stub(beyond_collecting_format_review_files?: false) }
      it "returns 'Edit Incomplete Format Review'" do
        expect(view.title).to eq 'Edit Incomplete Format Review'
      end
    end
    context "When the status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "returns 'Format Review Evaluation'" do
        expect(view.title).to eq 'Format Review Evaluation'
      end
    end
    context "When the status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "returns 'Edit Incomplete Final Submission'" do
        expect(view.title).to eq 'Edit Incomplete Final Submission'
      end
    end
    context "When the status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "returns 'Final Submission Evaluation'" do
        expect(view.title).to eq 'Final Submission Evaluation'
      end
    end
  end

  describe '#actions_partial_name' do
    context "When the status is before 'waiting for format review response'" do
      before { submission.stub(beyond_collecting_format_review_files?: false) }
      it "returns 'standard_actions'" do
        expect(view.actions_partial_name).to eq 'standard_actions'
      end
    end
    context "When the status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "returns 'format_review_evaluation_actions'" do
        expect(view.actions_partial_name).to eq 'format_review_evaluation_actions'
      end
    end
    context "When the status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "returns 'standard_actions'" do
        expect(view.actions_partial_name).to eq 'standard_actions'
      end
    end
    context "When the status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "returns 'final_submission_evaluation_actions'" do
        expect(view.actions_partial_name).to eq 'final_submission_evaluation_actions'
      end
    end
  end

  describe '#form_for_url' do
    context "When the status is before 'waiting for format review response'" do
      before { submission.stub(beyond_collecting_format_review_files?: false) }
      it "returns no path" do
        expect(view.form_for_url).to eq '#'
      end
    end
    context "When the status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "returns format review evaluation update path" do
        expect(view.form_for_url).to eq admin_submissions_format_review_response_path(submission)
      end
    end
    context "When the status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "returns no path" do
        expect(view.form_for_url).to eq '#'
      end
    end
    context "When the status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "returns final submission evaluation update path" do
        expect(view.form_for_url).to eq admin_submissions_final_submission_response_path(submission)
      end
    end
  end
end
