require 'component/component_spec_helper'
  include Rails.application.routes.url_helpers

describe SubmissionView do

  let(:submission) { create :submission }
  let(:view) { SubmissionView.new submission }

  describe '#name' do
    let(:program) { create :program, name: 'Phys Ed.' }
    let(:degree) { create :degree, name: 'Doctorate' }
    let(:submission) { create :submission, program: program,
                                           degree:  degree,
                                           semester: 'Spring',
                                           year: Date.new(2016, 06, 01).year }
    it "returns a formatted name for the submission" do
      expect(view.name).to eq 'Phys Ed. Doctorate - Spring 2016'
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
        before { submission.stub(collecting_committee?: true) }
        it "returns a link to complete step two" do
          expect(view.step_two_description).to eq "<a href='#{new_author_submission_committee_path(submission)}'>Provide committee</a>"
        end
      end
      context "when step two has been completed" do
        before { submission.stub(beyond_collecting_committee?: true) }
        it "returns a link to edit step two" do
          expect(view.step_two_description).to eq "Provide committee <a href='#' class='small'>[update]</a>"
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
      context "when step three is the current step" do
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
      context "when step three is the current step" do
        before { submission.status = 'collecting format review files' }
        it "returns a link to complete step three" do
          expect(view.step_three_description).to eq "<a href='#{new_author_submission_format_review_path(submission)}'>Upload Format Review files</a>"
        end
      end
      context "when step three has been completed" do
        before { submission.stub(beyond_collecting_format_review_files?: true) }
        it "returns a link to review the files" do
          expect(view.step_three_description).to eq "Upload Format Review files <a href='#' class='small'>[review]</a>"
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
    end
  end

  describe 'step four: Graduate school approves Format Review files' do
    describe '#step_four_class' do
      context 'when the submission is currently waiting for format review response' do
        before { submission.status = 'waiting for format review response' }
        it 'returns "current"' do
          expect(view.step_four_class).to eq 'current'
        end
      end
      context 'when the submission is not waiting for format review response' do
        before { submission.status = 'collecting format review files' }
        it 'returns an empty string' do
          expect(view.step_four_class).to eq ''
        end
      end
    end

    describe '#step_four_status' do
      context 'when the submission is currently waiting for format review response' do
        before { submission.status = 'waiting for format review response' }
        it 'returns "in process"' do
          expect(view.step_four_status).to eq 'in process'
        end
      end
      context 'when the submission is not waiting for format review response' do
        before { submission.status = 'collecting format review files' }
        it 'returns an empty string' do
          expect(view.step_four_status).to eq ''
        end
      end
    end
  end

end
