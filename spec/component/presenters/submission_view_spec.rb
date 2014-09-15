require 'component/presenters/component_presenters_spec_helper'

describe SubmissionView do

  let(:submission) { create :submission }
  let(:view) { SubmissionView.new submission }

  describe '#formatted_program_information' do
    let(:program) { create :program, name: 'Phys Ed.' }
    let(:degree) { create :degree, name: 'Doctorate' }
    let(:submission) { create :submission, program: program,
                                           degree:  degree,
                                           semester: 'Spring',
                                           year: Date.new(2016, 06, 01).year }
    it "returns a formatted name for the submission" do
      expect(view.formatted_program_information).to eq 'Phys Ed. Doctorate - Spring 2016'
    end
  end

  describe '#delete_link' do
    context "when step two is the current step" do
      before { submission.status = 'collecting committee' }
      it "returns a link to delete the submission" do
        expect(view.delete_link).to eq "<span class='delete-link'><a href='#{author_submission_path(submission)}' class='text-danger' data-method='delete' data-confirm='Permanently delete this submission?' rel='nofollow' >[delete]</a></span>"
      end
    end
    context "when step three is the current step for the first time" do
      before do
        submission.status = 'collecting format review files'
        submission.format_review_notes = nil
      end
      it "returns a link to delete the submission" do
        expect(view.delete_link).to eq "<span class='delete-link'><a href='#{author_submission_path(submission)}' class='text-danger' data-method='delete' data-confirm='Permanently delete this submission?' rel='nofollow' >[delete]</a></span>"
      end
    end
    context 'when the submission is beyond step three' do
      before { submission.stub(beyond_collecting_format_review_files?: true) }
      it "returns an empty string" do
        expect(view.delete_link).to eq ''
      end
    end
    context 'when step three is the current step after my format review is rejected' do
      before do
        submission.status = 'collecting format review files'
        submission.format_review_notes = 'some format review notes'
      end
      it "returns an empty string" do
        expect(view.delete_link).to eq ''
      end
    end
  end

  describe '#created_on' do
    before do
      submission.created_at = Time.new 2014, 7, 4
    end
    it 'returns the formatted date' do
      expect(view.created_on).to eq 'July 4, 2014'
    end
  end

  describe '#step_one_description' do
    context "when step two is the current step" do
      before { submission.status = 'collecting committee' }
      it "returns a link to edit step one" do
        expect(view.step_one_description).to eq "Provide program information <a href='#{edit_author_submission_path(submission)}' class='small'>[update]</a>"
      end
    end
    context "when step three is the current step" do
      before { submission.status = 'collecting format review files' }
      it "returns a link to edit step one" do
        expect(view.step_one_description).to eq "Provide program information <a href='#{edit_author_submission_path(submission)}' class='small'>[update]</a>"
      end
    end
    context "when the submission is beyond step three" do
      before { submission.stub(beyond_collecting_format_review_files?: true) }
      it "returns a link to review step two" do
        expect(view.step_one_description).to eq "Provide program information <a href='#{author_submission_program_information_path(submission)}' class='small'>[review]</a>"
      end
    end
  end

  describe 'step two: committee' do
    describe '#step_two_class' do
      context 'when the submission has no committee' do
        before { submission.status = 'collecting committee' }
        it 'returns "current"' do
          expect(view.step_two_class).to eq 'current'
        end
      end
      context 'when the submission has a committee' do
        before { submission.stub(beyond_collecting_committee?: true) }
        it 'returns "complete"' do
          expect(view.step_two_class).to eq 'complete'
        end
      end
    end

    describe '#step_two_description' do
      context "when the submission is on step one" do
        before { submission.status = 'collecting program information' }
        it "returns the step two label" do
          expect(view.step_two_description).to eq 'Provide committee'
        end
      end
      context "when step two is the current step" do
        before { submission.status = 'collecting committee' }
        it "returns a link to complete step two" do
          expect(view.step_two_description).to eq "<a href='#{new_author_submission_committee_path(submission)}'>Provide committee</a>"
        end
      end
      context "when step three is the current step" do
        before { submission.status = 'collecting format review files' }
        it "returns a link to edit step two" do
          expect(view.step_two_description).to eq "Provide committee <a href='#{edit_author_submission_committee_path(submission)}' class='small'>[update]</a>"
        end
      end
      context "when the submission is beyond step three" do
        before { submission.stub(beyond_collecting_format_review_files?: true) }
        it "returns a link to review step two" do
          expect(view.step_two_description).to eq "Provide committee <a href='#{author_submission_committee_path(submission)}' class='small'>[review]</a>"
        end
      end
    end

    describe '#step_two_status' do
      context 'when the submission has no committee' do
        before { submission.stub(beyond_collecting_committee?: false) }
        it 'returns an empty string' do
          expect(view.step_two_status).to eq ''
        end
      end
      context 'when the submission has a committee' do
        before { submission.stub(beyond_collecting_committee?: true) }
        it 'returns completed' do
          expect(view.step_two_status).to eq "<span class='glyphicon glyphicon-ok-circle'></span> completed"
        end
      end
    end
  end

  describe 'step three: upload format review files' do
    describe '#step_three_class' do
      context "when the submission is before step three" do
        before { submission.stub(beyond_collecting_committee?: false) }
        it "returns an empty string" do
          expect(view.step_three_class).to eq ''
        end
      end
      context "when step three is the current step for the first time" do
        before { submission.status = 'collecting format review files' }
        it "returns 'current'" do
          expect(view.step_three_class).to eq 'current'
        end
      end
      context "when step three has been completed" do
        before { submission.stub(beyond_collecting_format_review_files?: true) }
        it "returns 'complete'" do
          expect(view.step_three_class).to eq 'complete'
        end
      end
    end

    describe '#step_three_description' do
      context "when the submission is before step three" do
        before { submission.stub(beyond_collecting_committee?: false) }
        it "returns the step three label" do
          expect(view.step_three_description).to eq 'Upload Format Review files'
        end
      end
      context "when step three is the current step for the first time" do
        before do
          submission.status = 'collecting format review files'
          submission.format_review_notes = nil
        end
        it "returns a link to complete step three" do
          expect(view.step_three_description).to eq "<a href='#{author_submission_edit_format_review_path(submission)}'>Upload Format Review files</a>"
        end
      end
      context 'when step three is the current step after my format review is rejected' do
        before do
          submission.status = 'collecting format review files'
          submission.format_review_notes = 'some format review notes'
        end
        it "returns a link to edit step three" do
          expect(view.step_three_description).to eq "Upload Format Review files <a href='#{author_submission_edit_format_review_path(submission)}' class='small'>[update]</a>"
        end
      end
      context "when the submission is beyond step three" do
        before { submission.stub(beyond_collecting_format_review_files?: true) }
        it "returns a link to review the files" do
          expect(view.step_three_description).to eq "Upload Format Review files <a href='#{author_submission_format_review_path(submission)}' class='small'>[review]</a>"
        end
      end
    end

    describe '#step_three_status' do
      context "when the submission is before step three" do
        before { submission.stub(beyond_collecting_format_review_files?: false) }
        it 'returns an empty string' do
          expect(view.step_three_status).to eq ''
        end
      end
      context 'when step three has been completed' do
        before { submission.stub(beyond_collecting_format_review_files?: true) }
        it 'returns completed' do
          expect(view.step_three_status).to eq "<span class='glyphicon glyphicon-ok-circle'></span> completed"
        end
      end
      context 'when step three is the current step after my format review is rejected' do
        before do
          submission.status = 'collecting format review files'
          submission.format_review_notes = 'some format review notes'
        end
        it 'returns rejection instructions' do
          expect(view.step_three_status).to eq "<span class='fa fa-exclamation-circle'></span> rejected, please see the <a href='#{author_submission_edit_format_review_path(submission, anchor: 'format-review-notes')}'>notes from the administrator</a>"
        end
      end
    end
  end

  describe 'step four: Graduate school approves Format Review files' do
    describe '#step_four_class' do
      context 'when the submission is before waiting for format review response' do
        before { submission.stub(beyond_collecting_format_review_files?: false) }
        it 'returns an empty string' do
          expect(view.step_four_class).to eq ''
        end
      end
      context 'when the submission is currently waiting for format review response' do
        before { submission.status = 'waiting for format review response' }
        it 'returns "current"' do
          expect(view.step_four_class).to eq 'current'
        end
      end
      context "when the submission's Format Review files have been approved" do
        before { submission.stub(beyond_waiting_for_format_review_response?: true) }
        it "returns 'complete'" do
          expect(view.step_four_class).to eq 'complete'
        end
      end
    end

    describe '#step_four_status' do
      context 'when the submission is before waiting for format review response' do
        before { submission.status = 'collecting format review files' }
        it 'returns an empty string' do
          expect(view.step_four_status).to eq ''
        end
      end
      context 'when the submission is currently waiting for format review response' do
        before { submission.status = 'waiting for format review response' }
        it 'returns "under review by an administrator"' do
          expect(view.step_four_status).to eq "<span class='fa fa-warning'></span> under review by an administrator"
        end
      end
      context "when the submission's Format Review files have been approved" do
        before { submission.stub(beyond_waiting_for_format_review_response?: true) }
        it 'returns approved' do
          expect(view.step_four_status).to eq "<span class='glyphicon glyphicon-ok-circle'></span> approved"
        end
      end
    end
  end

  describe 'step five: Upload Final Submission files' do
    describe '#step_five_class' do
      context "when the submission is before step five" do
        before { submission.stub(beyond_waiting_for_format_review_response?: false) }
        it "returns an empty string" do
          expect(view.step_five_class).to eq ''
        end
      end
      context "when step five is the current step" do
        before { submission.status = 'collecting final submission files' }
        it "returns 'current'" do
          expect(view.step_five_class).to eq 'current'
        end
      end
      context "when step five has been completed" do
        before { submission.stub(beyond_collecting_final_submission_files?: true) }
        it "returns 'complete'" do
          expect(view.step_five_class).to eq 'complete'
        end
      end
    end

    describe '#step_five_description' do
      context "when the submission is before step five" do
        before { submission.stub(beyond_waiting_for_format_review_response?: false) }
        it "returns the step five label" do
          expect(view.step_five_description).to eq 'Upload Final Submission files'
        end
      end
      context "when step five is the current step" do
        before { submission.status = 'collecting final submission files' }
        it "returns a link to complete step five" do
         expect(view.step_five_description).to eq "<a href='#{author_submission_edit_final_submission_path(submission)}'>Upload Final Submission files</a>"
        end
      end
      context "when step five has been completed" do
        before { submission.stub(beyond_collecting_final_submission_files?: true) }
        it "returns a link to review the files" do
          expect(view.step_five_description).to eq "Upload Final Submission files <a href='#' class='small'>[review]</a>"
        end
      end
    end

    describe '#step_five_status' do
      context "when the submission is before step five" do
        before { submission.stub(beyond_waiting_for_format_review_response?: false) }
        it 'returns an empty string' do
          expect(view.step_five_status).to eq ''
        end
      end
      context 'when step five has been completed' do
        before { submission.stub(beyond_collecting_final_submission_files?: true) }
        it 'returns completed' do
          expect(view.step_five_status).to eq "<span class='glyphicon glyphicon-ok-circle'></span> completed"
        end
      end
    end
  end

  describe 'step six: Graduate school approves Final Submission files' do
    describe '#step_six_class' do
      context "when the submission is before step six" do
        before { submission.stub(beyond_collecting_final_submission_files?: false) }
        it "returns an empty string" do
          expect(view.step_six_class).to eq ''
        end
      end
      context "when step six is the current step" do
        before { submission.status = 'waiting for final submission response' }
        it "returns 'current'" do
          expect(view.step_six_class).to eq 'current'
        end
      end
      context "when step six has been completed" do
        before { submission.stub(beyond_waiting_for_final_submission_response?: true) }
        it "returns 'complete'" do
          expect(view.step_six_class).to eq 'complete'
        end
      end
    end

    describe '#step_six_status' do
      context 'when the submission is before waiting for final submission response' do
        before { submission.status = 'collecting final submission files' }
        it 'returns an empty string' do
          expect(view.step_six_status).to eq ''
        end
      end
      context 'when the submission is currently waiting for final submission response' do
        before { submission.status = 'waiting for final submission response' }
        it 'returns "under review by an administrator"' do
          expect(view.step_six_status).to eq "<span class='fa fa-warning'></span> under review by an administrator"
        end
      end
      context "when the submission's Final Submission files have been approved" do
        before { submission.stub(beyond_waiting_for_final_submission_response?: true) }
        it 'returns approved' do
          expect(view.step_six_status).to eq "<span class='glyphicon glyphicon-ok-circle'></span> approved"
        end
      end
    end
  end

end
