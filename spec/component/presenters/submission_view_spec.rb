require 'component/component_spec_helper'

describe SubmissionView do

  let(:submission) { create :submission }
  let(:view_with_submission) { SubmissionView.new submission }
  let(:view_without_submission) { SubmissionView.new }


  describe '#id' do
    context 'when the submission exists' do
      it 'returns a formatted submission id' do
        expect(view_with_submission.id).to eq("submission-#{submission.id}")
      end
    end
    context 'when the submission is nil' do
      it 'returns an empty string' do
        expect(view_without_submission.id).to eq('')
      end
    end
  end

  describe 'step one: program information' do
    describe '#step_one_class' do
      context 'when the submission exists' do
        it 'returns "complete"' do
          expect(view_with_submission.step_one_class).to eq('complete')
        end
      end
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.step_one_class).to eq('')
        end
      end
    end

    describe '#step_one_status' do
      context 'when the submission exists' do
        it 'returns when the submission was created' do
          expect(view_with_submission.step_one_status).to eq("<span class='glyphicon glyphicon-ok-circle'></span> completed on #{submission.created_on}")
        end
      end
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.step_one_status).to eq('')
        end
      end
    end

    describe '#program_information_link' do
      context 'when the submission exists' do
        it 'returns a link to edit the program information' do
          expect(view_with_submission.program_information_link).to eq("<a href='#' class='small'>[update]</a>")
        end
      end
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.program_information_link).to eq('')
        end
      end
    end
  end

  describe 'step two: committee' do
    let(:view_on_step_two) { SubmissionView.new submission }
    describe '#step_two_class' do
      context 'when the submission exists and does not yet have a committee' do
        it 'returns "current"' do
          expect(view_on_step_two.step_two_class).to eq('current')
        end
      end
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.step_two_class).to eq('')
        end
      end
    end
  end

end