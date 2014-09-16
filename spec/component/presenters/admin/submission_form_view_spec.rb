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

end
