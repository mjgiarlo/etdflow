require 'component/component_spec_helper'

describe Submission do

  specify { expect(subject).to have_db_column :author_id }
  specify { expect(subject).to have_db_column :program_id }
  specify { expect(subject).to have_db_column :degree_id }
  specify { expect(subject).to have_db_column :semester }
  specify { expect(subject).to have_db_column :year }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }

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

end
