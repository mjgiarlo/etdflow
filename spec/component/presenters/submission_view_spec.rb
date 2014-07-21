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

  describe '#submission_status' do
    it 'returns the status of the associated submission' do
      expect(view_with_submission.submission_status).to eq(view_with_submission.submission.status)
    end
    it 'returns nil when there is no submission' do
      expect(view_without_submission.submission_status).to be_nil
    end
  end

  describe '#submission_with_committee?' do
    it 'returns false when there is no submission' do
      expect(view_without_submission.submission_with_committee?).to_not be_true
    end
    it 'returns false when the submission exists and has no committee' do
      expect(view_with_submission.submission_with_committee?).to_not be_true
    end
    it 'returns true when the submission has a committee' do
      collect_committee(submission)
      expect(view_with_submission.submission_with_committee?).to be_true
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
          expect(view_with_submission.program_information_link).to eq("<a href='/author/submissions/#{submission.id}/edit' class='small'>[update]</a>")
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
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.step_two_class).to eq('')
        end
      end
      context 'when the submission exists and has no committee' do
        before { submission.status = 'collecting committee' }
        it 'returns "current"' do
          expect(view_on_step_two.step_two_class).to eq('current')
        end
      end
      context 'when the submission has a committee' do
        before { collect_committee(submission) }
        it 'returns "complete"' do
          expect(view_on_step_two.step_two_class).to eq('complete')
        end
      end
    end

    describe '#step_two_status' do
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.step_two_status).to eq('')
        end
      end
      context 'when the submission exists and has no committee' do
        before { submission.status = 'collecting committee' }
        it 'returns an empty string' do
          expect(view_on_step_two.step_two_status).to eq('')
        end
      end
      context 'when the submission has a committee' do
        before { collect_committee(submission) }
        it 'returns completed' do
          expect(view_on_step_two.step_two_status).to eq("<span class='glyphicon glyphicon-ok-circle'></span> completed")
        end
      end
    end

    describe '#committee_link' do
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.committee_link).to eq('')
        end
      end
      context 'when the submission exists and has no committee' do
        before { submission.status = 'collecting committee' }
        it 'returns an empty string' do
          expect(view_on_step_two.committee_link).to eq('')
        end
      end
      context 'when the submission has a committee' do
        before { collect_committee(submission) }
        it 'returns a link to edit the committee' do
          expect(view_on_step_two.committee_link).to eq("<a href='#' class='small'>[update]</a>")
        end
      end
    end

  end

  describe 'step three: upload format review files' do
    let(:view_on_step_three) { SubmissionView.new submission }

    describe '#step_three_class' do
      context 'when the submission is nil' do
        it 'returns an empty string' do
          expect(view_without_submission.step_three_class).to eq('')
        end
      end
      context 'when the submission status is "collecting format review files"' do
        before { submission.status = 'collecting format review files' }
        it 'returns "current"' do
          expect(view_on_step_three.step_three_class).to eq('current')
        end
      end
    end

  end

  def collect_committee(submission)
    create :committee_member, submission: submission,
                              role: Committee.advisor,
                              name: Committee.advisor + "name",
                              email: Committee.advisor + "@example.com",
                              is_advisor: true

    Committee.additional_roles.each do |role|
      create :committee_member, submission: submission,
                                role: role,
                                name: role + "name",
                                email: role + "email",
                                is_advisor: false
    end
  end

end
