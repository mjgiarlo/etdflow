require 'component/component_spec_helper'

describe SubmissionStatusGiver do

  let(:submission) { create :submission }

  describe '#collecting_committee!' do

    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "updates status to 'collecting committee'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_committee!
        expect(submission.status).to eq 'collecting committee'
      end 
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_committee!
        expect(submission.status).to eq 'collecting committee'
      end 
    end

    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is beyond 'collecting format review files'" do
      before { submission.status = 'waiting for format review response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end 

  describe '#collecting_format_review_files!' do

    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_format_review_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "updates status to 'collecting format review files'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_format_review_files!
        expect(submission.status).to eq 'collecting format review files'
      end
    end

    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_format_review_files!
        expect(submission.status).to eq 'collecting format review files'
      end 
    end

    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "updates status to 'collecting format review files'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_format_review_files!
        expect(submission.status).to eq 'collecting format review files'
      end
    end

    context "when status is beyond 'waiting for format review response'" do
      before { submission.status = 'collecting final submission files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end 

  describe '#waiting_for_format_review_response!' do
    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "updates status to 'waiting for format review response'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_format_review_response!
        expect(submission.status).to eq('waiting for format review response')
      end
    end
    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_format_review_response!
        expect(submission.status).to eq('waiting for format review response')
      end
    end
    context 'when status is a different valid value' do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end

  describe '#collecting_final_submission_files!' do
    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_final_submission_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "updates status to 'collecting final submission files'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_final_submission_files!
        expect(submission.status).to eq('collecting final submission files')
      end
    end
    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_final_submission_files!
        expect(submission.status).to eq('collecting final submission files')
      end
    end
  end
end
