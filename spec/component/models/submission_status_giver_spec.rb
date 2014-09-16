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

    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_committee!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
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

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_format_review_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_format_review_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_format_review_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_format_review_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end 

  describe '#waiting_for_format_review_response!' do
    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "updates status to 'waiting for format review response'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_format_review_response!
        expect(submission.status).to eq 'waiting for format review response'
      end
    end

    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_format_review_response!
        expect(submission.status).to eq 'waiting for format review response'
      end
    end

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_format_review_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end

  describe '#collecting_final_submission_files!' do
    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_final_submission_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_final_submission_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

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
        expect(submission.status).to eq 'collecting final submission files'
      end
    end

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_final_submission_files!
        expect(submission.status).to eq 'collecting final submission files'
      end
    end


    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "updates status to 'collecting final submission files'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.collecting_final_submission_files!
        expect(submission.status).to eq 'collecting final submission files'
      end
    end

    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_final_submission_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.collecting_final_submission_files!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end

  describe '#waiting_for_final_submission_response!' do
    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_final_submission_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_final_submission_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_final_submission_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_final_submission_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "updates status to 'waiting for final submission response'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_final_submission_response!
        expect(submission.status).to eq 'waiting for final submission response'
      end
    end

    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_final_submission_response!
        expect(submission.status).to eq 'waiting for final submission response'
      end
    end


    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_final_submission_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_final_submission_response!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end

  describe '#waiting_for_publication_release!' do
    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_publication_release!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_publication_release!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_publication_release!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_publication_release!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_publication_release!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "updates status to 'waiting for publication release'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_publication_release!
        expect(submission.status).to eq 'waiting for publication release'
      end
    end


    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.waiting_for_publication_release!
        expect(submission.status).to eq 'waiting for publication release'
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.waiting_for_publication_release!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end
  end

  describe '#released_for_publication!' do
    context "when status is 'collecting program information'" do
      before { submission.status = 'collecting program information' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.released_for_publication!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.released_for_publication!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.released_for_publication!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for format review response'" do
      before { submission.status = 'waiting for format review response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.released_for_publication!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'collecting final submission files'" do
      before { submission.status = 'collecting final submission files' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.released_for_publication!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end

    context "when status is 'waiting for final submission response'" do
      before { submission.status = 'waiting for final submission response' }
      it "raises an exception" do
        giver = SubmissionStatusGiver.new(submission)
        expect {giver.released_for_publication!}.to raise_error(SubmissionStatusGiver::InvalidTransition)
      end
    end


    context "when status is 'waiting for publication release'" do
      before { submission.status = 'waiting for publication release' }
      it "updates status to 'released for publication'" do
        giver = SubmissionStatusGiver.new(submission)
        giver.released_for_publication!
        expect(submission.status).to eq 'released for publication'
      end
    end

    context "when status is 'released for publication'" do
      before { submission.status = 'released for publication' }
      it "does not change the status" do
        giver = SubmissionStatusGiver.new(submission)
        giver.released_for_publication!
        expect(submission.status).to eq 'released for publication'
      end
    end
  end

end
