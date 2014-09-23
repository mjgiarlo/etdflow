require 'component/presenters/component_presenters_spec_helper'

describe Admin::SubmissionFormView do

  let(:view) { Admin::SubmissionFormView.new(submission, session) }
  let(:submission) { create :submission }
  let(:session) { {} }

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

  describe '#cancellation_path' do
    context "When the status is before 'waiting for format review response'" do
      let(:session) { { return_to: "/admin/#{submission.parameterized_degree_type}/format_review_incomplete" } }
      before { submission.stub(beyond_collecting_format_review_files?: false) }
      it "returns incomplete format review path" do
        expect(view.cancellation_path).to eq admin_submissions_index_path(submission.parameterized_degree_type, 'format_review_incomplete')
      end
    end
    context "When the status is 'waiting for format review response'" do
      let(:session) { { return_to: "/admin/#{submission.parameterized_degree_type}/format_review_submitted" } }
      before { submission.status = 'waiting for format review response' }
      it "returns submitted format review path" do
        expect(view.cancellation_path).to eq admin_submissions_index_path(submission.parameterized_degree_type, 'format_review_submitted')
      end
    end
    context "When the status is 'collecting final submission files'" do
      let(:session) { { return_to: "/admin/#{submission.parameterized_degree_type}/final_submission_incomplete" } }
      before { submission.status = 'collecting final submission files' }
      it "returns incomplete final submission path" do
        expect(view.cancellation_path).to eq admin_submissions_index_path(submission.parameterized_degree_type, 'final_submission_incomplete')
      end
    end
    context "When the status is 'waiting for final submission response'" do
      let(:session) { { return_to: "/admin/#{submission.parameterized_degree_type}/final_submission_submitted" } }
      before { submission.status = 'waiting for final submission response' }
      it "returns submitted final submission path" do
        expect(view.cancellation_path).to eq admin_submissions_index_path(submission.parameterized_degree_type, 'final_submission_submitted')
      end
    end
    context "When the status is 'waiting for publication release'" do
      let(:session) { { return_to: "/admin/#{submission.parameterized_degree_type}/final_submission_approved" } }
      before { submission.status = 'waiting for publication release' }
      it "returns approved final submission path" do
        expect(view.cancellation_path).to eq admin_submissions_index_path(submission.parameterized_degree_type, 'final_submission_approved')
      end
    end
    context "When the status is 'released for publication'" do
      let(:session) { { return_to: "/admin/#{submission.parameterized_degree_type}/released_for_publication" } }
      before { submission.status = 'released for publication' }
      it "returns released for publication path" do
        expect(view.cancellation_path).to eq admin_submissions_index_path(submission.parameterized_degree_type, 'released_for_publication')
      end
    end
  end
end
