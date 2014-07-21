require 'component/component_spec_helper'

describe Submission do

  specify { expect(subject).to have_db_column :author_id }
  specify { expect(subject).to have_db_column :program_id }
  specify { expect(subject).to have_db_column :degree_id }
  specify { expect(subject).to have_db_column :semester }
  specify { expect(subject).to have_db_column :year }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }
  specify { expect(subject).to have_db_column :status }

  specify { expect(subject).to validate_presence_of :author_id }
  specify { expect(subject).to validate_presence_of :program_id }
  specify { expect(subject).to validate_presence_of :degree_id }
  specify { expect(subject).to validate_presence_of :semester }
  specify { expect(subject).to validate_presence_of :year }

  specify { expect(subject).to belong_to :author }
  specify { expect(subject).to belong_to :degree }
  specify { expect(subject).to belong_to :program }

  specify { expect(subject).to have_many :committee_members }

  specify { expect(subject).to ensure_inclusion_of(:semester).in_array(Submission::SEMESTERS) }

  specify { expect(subject).to validate_numericality_of :year }

  specify { expect(subject).to ensure_inclusion_of(:status).in_array(Submission.statuses) }

  let(:submission) { create :submission }

  describe '#program_name' do
    it 'returns the name of the associated program' do
      expect(submission.program_name).to eq(submission.program.name)
    end
  end

  describe '#degree_name' do
    it 'returns the name of the associated degree' do
      expect(submission.degree_name).to eq(submission.degree.name)
    end
  end

  describe '.years' do
    it 'Returns an array containing the current year plus 3 more' do
      today = Date.today
      expect(Submission.years).to eq ["#{today.year}", "#{(today+1.year).year}", "#{(today+2.years).year}", "#{(today+3.years).year}"]
    end
  end

  describe '#created_on' do
    let(:new_submission) { Submission.new }
    context 'for a new record' do
      it 'returns nil' do
        expect(new_submission.created_on).to be_nil
      end
    end
    context 'when the submission exists' do
      before do
        new_submission.created_at = Time.new(2014, 7, 4)
      end
      it 'returns the formatted date' do
        expect(new_submission.created_on).to eq('July 4, 2014')
      end
    end
  end

  describe '#collecting_committee?' do
    context "when status is not set" do
      before { submission.status = nil }
      it "returns false" do
        expect(submission).to_not be_collecting_committee
      end
    end
    context "when status is set to 'collecting committee'" do
      before { submission.status = "collecting committee" }
      it "returns true" do
        expect(submission).to be_collecting_committee
      end
    end
  end

  describe '#has_committee?' do
    context 'when there are no committee members' do
      it 'returns false' do
        expect(submission.has_committee?).to be_false
      end
    end
    context 'when only one member exists' do
      before { create :committee_member, submission: submission }
      it 'returns false' do
        expect(submission.has_committee?).to be_false
      end
    end
    context 'when the minimum number of members exist' do
      before do
        Committee.minimum_number_of_members.times do
          create :committee_member, submission: submission
        end
      end
      it 'returns true' do
        expect(submission.has_committee?).to be_true
      end
    end
  end

  describe '#collecting_committee!' do
    context 'when status has been set to nil' do
      before { submission.status = nil }
      it "saves status as 'collecting committee'" do
        submission.collecting_committee!
        expect(submission.status).to eq('collecting committee')
      end
    end
    context "when status has been set to 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "does not change status" do
        expect(submission.status).to eq('collecting committee')
      end
    end
    context 'when status has been set to a different valid value' do
      before { submission.status = 'collecting format review papers' }
      it "raises an error" do
        expect { submission.collecting_committee! }.to raise_error(Submission::InvalidTransition)
      end
    end
  end

  describe '#collecting_format_review_files!' do
    context "when status has been set to 'collecting committee'" do
      before { submission.status = 'collecting committee' }
      it "saves status as 'collecting format review files'" do
        submission.collecting_format_review_files!
        expect(submission.status).to eq('collecting format review files')
      end
    end
    context "when status has been set to 'collecting format review files'" do
      before { submission.status = 'collecting format review files' }
      it "does not change status" do
        expect(submission.status).to eq('collecting format review files')
      end
    end
    context 'when status has been set to a different valid value' do
      before { submission.status = nil }
      it "raises an error" do
        expect { submission.collecting_format_review_files! }.to raise_error(Submission::InvalidTransition)
      end
    end
  end

end
