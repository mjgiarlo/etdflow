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
  specify { expect(subject).to have_db_column :title }
  specify { expect(subject).to have_db_column :format_review_notes }
  specify { expect(subject).to have_db_column :final_submission_notes }
  specify { expect(subject).to have_db_column :defended_at }
  specify { expect(subject).to have_db_column :abstract }
  specify { expect(subject).to have_db_column :keywords }
  specify { expect(subject).to have_db_column :access_level }
  specify { expect(subject).to have_db_column :has_agreed_to_terms }
  specify { expect(subject).to have_db_column :committee_provided_at }
  specify { expect(subject).to have_db_column :format_review_files_uploaded_at }
  specify { expect(subject).to have_db_column :format_review_rejected_at }
  specify { expect(subject).to have_db_column :format_review_approved_at }
  specify { expect(subject).to have_db_column :final_submission_files_uploaded_at }
  specify { expect(subject).to have_db_column :final_submission_rejected_at }
  specify { expect(subject).to have_db_column :final_submission_approved_at }

  specify { expect(subject).to validate_presence_of :author_id }
  specify { expect(subject).to validate_presence_of :title }
  specify { expect(subject).to validate_presence_of :program_id }
  specify { expect(subject).to validate_presence_of :degree_id }
  specify { expect(subject).to validate_presence_of :semester }
  specify { expect(subject).to validate_presence_of :year }

  specify { expect(subject).to belong_to :author }
  specify { expect(subject).to belong_to :degree }
  specify { expect(subject).to belong_to :program }

  specify { expect(subject).to have_many :committee_members }
  specify { expect(subject).to have_many :format_review_files }
  specify { expect(subject).to have_many :final_submission_files }


  specify { expect(subject).to ensure_inclusion_of(:semester).in_array(Submission::SEMESTERS) }
  specify { expect(subject).to ensure_inclusion_of(:access_level).in_array(Submission::ACCESS_LEVELS) }

  specify { expect(subject).to validate_numericality_of :year }

  specify { expect(subject).to ensure_inclusion_of(:status).in_array(Submission.statuses) }

  specify { expect(subject).to accept_nested_attributes_for :committee_members }
  specify { expect(subject).to accept_nested_attributes_for :format_review_files }
  specify { expect(subject).to accept_nested_attributes_for :final_submission_files }

  let(:submission) { create :submission }

  describe 'validates presence of format review notes' do
    context 'when beyond collecting format review files' do
      before { submission.stub(beyond_collecting_format_review_files?: true) }
      context 'when there are format review notes' do
        before { submission.format_review_notes = "Looks good!" }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there are no format review notes' do
        before { submission.format_review_notes = nil }
        it 'is not valid' do
          expect(submission).to_not be_valid
        end
      end
    end
    context 'when collecting program information' do
      before { submission.status = 'collecting program information' }
      context 'when there are no format review notes' do
        before { submission.format_review_notes = nil }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
    end
  end

  describe 'validates presence of final submission fields' do
    context 'when beyond waiting for format review response' do
      let(:submission) { create :submission, :collecting_final_submission_files }
      context 'when there is a defended_at value' do
        before { submission.defended_at = Time.zone.now }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there is no defended_at value' do
        before { submission.defended_at = nil }
        it 'is not valid' do
          expect(submission).to_not be_valid
        end
      end
      context 'when there is an abstract value' do
        before { submission.abstract = 'My abstract' }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there is no abstract value' do
        before { submission.abstract = nil }
        it 'is not valid' do
          expect(submission).to_not be_valid
        end
      end
      context 'when there are keywords' do
        before { submission.keywords = 'keyword one, keyword two' }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there are no keywords' do
        before { submission.keywords = nil }
        it 'is not valid' do
          expect(submission).to_not be_valid
        end
      end
      context 'when there is an access level' do
        before { submission.access_level = 'open_access' }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there is no access level' do
        before { submission.access_level = nil }
        it 'is not valid' do
          expect(submission).to_not be_valid
        end
      end
    end
    context 'when collecting program information' do
      before { submission.status = 'collecting program information' }
      context 'when there is no defended_at value' do
        before { submission.defended_at = nil }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there is no abstract value' do
        before { submission.abstract = nil }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there are no keywords' do
        before { submission.keywords = nil }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there is no access level' do
        before { submission.access_level = nil }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
    end
  end

  describe "validation of agreement to terms" do
    context 'when beyond waiting for format review response' do
      let(:submission) { create :submission, :collecting_final_submission_files }
      context "when has_agreed_to_terms is true" do
        before do
          submission.has_agreed_to_terms = true
          submission.valid?
        end
        it "should be valid" do
          expect(submission.errors[:base]).to be_empty
        end
      end
      context "when has_agreed_to_terms is false" do
        before do
          submission.has_agreed_to_terms = false
          submission.valid?
        end
        it "should not be valid" do
          expect(submission.errors[:base]).to_not be_empty
        end
      end
    end
    context 'when collecting program information' do
      before { submission.status = 'collecting program information' }
      context "when has_agreed_to_terms is true" do
        before do
          submission.has_agreed_to_terms = true
          submission.valid?
        end
        it "should be valid" do
          expect(submission.errors[:base]).to be_empty
        end
      end
      context "when has_agreed_to_terms is false" do
        before do
          submission.has_agreed_to_terms = false
          submission.valid?
        end
        it "should be valid" do
          expect(submission.errors[:base]).to be_empty
        end
      end
    end
  end

  describe 'validates presence of final submission notes' do
    context 'when beyond collecting final submission files' do
      let(:submission) { create :submission, :waiting_for_final_submission_response }
      context 'when there are final submission notes' do
        before { submission.final_submission_notes = "Looks good!" }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
      context 'when there are no final submission notes' do
        before { submission.final_submission_notes = nil }
        it 'is not valid' do
          expect(submission).to_not be_valid
        end
      end
    end
    context 'when collecting program information' do
      before { submission.status = 'collecting program information' }
      context 'when there are no final submission notes' do
        before { submission.final_submission_notes = nil }
        it 'is valid' do
          expect(submission).to be_valid
        end
      end
    end
  end

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

  describe '#degree_type' do
    it 'returns the degree_type of the associated degree' do
      expect(submission.degree_type).to eq(submission.degree.degree_type)
    end
  end

  describe '#author_first_name' do
    it 'returns the first name of the associated author' do
      expect(submission.author_first_name).to eq(submission.author.first_name)
    end
  end

  describe '#author_last_name' do
    it 'returns the last name of the associated author' do
      expect(submission.author_last_name).to eq(submission.author.last_name)
    end
  end

  describe "Degree type scopes:" do
    Degree.degree_types_json.each do |type|
      symbol_name = type["parameter"].to_sym
      let!(symbol_name) { create :submission, symbol_name }
    end

    Degree.degree_types_json.each do |type|
      method_name = type["parameter"]
      describe "." + method_name do
        it "returns only submissions whose degree type is #{type["singular"]}" do
          degrees_of_this_type = Degree.where(degree_type: type["singular"])
          expect(degrees_of_this_type.count).to eq 1
          only_degree_of_this_type = degrees_of_this_type.first
          expected_relation = Submission.where(degree: only_degree_of_this_type)
          expect(Submission.send method_name).to match_array(expected_relation)
        end
      end
    end
  end

  describe '#parameterized_degree_type' do
    degree_type_symbol = Degree.default_degree_type.to_sym
    let(:submission) { create :submission, degree_type_symbol }
    it 'returns the parameterized version of the associated degrees degree type' do
      expect(submission.parameterized_degree_type).to eq Degree.default_degree_type
    end
  end

  describe '.format_review_is_incomplete' do
    before do
      create :submission, :collecting_program_information
      create :submission, :collecting_committee
      create :submission, :collecting_format_review_files
      create :submission, :waiting_for_format_review_response
    end
    it "returns submissions whose format reviews have not yet been submitted or are currently rejected" do
      expect(Submission.format_review_is_incomplete.count).to eq 3
    end
  end

  describe '.format_review_is_submitted' do
    before do
      create :submission, :collecting_program_information
      create :submission, :collecting_committee
      create :submission, :collecting_format_review_files
      create :submission, :waiting_for_format_review_response
    end
    it "returns submissions whose format reviews have been submitted for review" do
      expect(Submission.format_review_is_submitted.count).to eq 1
    end
  end

  describe '.final_submission_is_incomplete' do
    before do
      create :submission, :collecting_program_information
      create :submission, :collecting_committee
      create :submission, :collecting_format_review_files
      create :submission, :waiting_for_format_review_response
      create :submission, :collecting_final_submission_files
    end
    it "returns submissions whose final submission has not yet been submitted or are currently rejected" do
      expect(Submission.final_submission_is_incomplete.count).to eq 1
    end
  end

  describe '.final_submission_is_submitted' do
    before do
      create :submission, :collecting_program_information
      create :submission, :collecting_committee
      create :submission, :collecting_format_review_files
      create :submission, :waiting_for_format_review_response
      create :submission, :collecting_final_submission_files
      create :submission, :waiting_for_final_submission_response
    end
    it "returns submissions whose final submissions have been submitted for review" do
      expect(Submission.final_submission_is_submitted.count).to eq 1
    end
  end

  describe '.years' do
    it 'Returns an array containing the current year plus 3 more' do
      today = Date.today
      expect(Submission.years).to eq ["#{today.year}", "#{(today+1.year).year}", "#{(today+2.years).year}", "#{(today+3.years).year}"]
    end
  end

  describe '#collecting_program_information?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting committee' }
      it "returns false" do
        expect(submission).to_not be_collecting_program_information
      end
    end
    context "when status is set to 'collecting program information'" do
      before { submission.status = "collecting program information" }
      it "returns true" do
        expect(submission).to be_collecting_program_information
      end
    end
  end

  describe '#collecting_committee?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
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

  describe '#collecting_format_review_files?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
      it "returns false" do
        expect(submission).to_not be_collecting_format_review_files
      end
    end
    context "when status is set to 'collecting format review files'" do
      before { submission.status = "collecting format review files" }
      it "returns true" do
        expect(submission).to be_collecting_format_review_files
      end
    end
  end

  describe '#waiting_for_format_review_response?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
      it "returns false" do
        expect(submission).to_not be_waiting_for_format_review_response
      end
    end
    context "when status is set to 'waiting for format review response'" do
      before { submission.status = "waiting for format review response" }
      it "returns true" do
        expect(submission).to be_waiting_for_format_review_response
      end
    end
  end

  describe '#collecting_final_submission_files?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
      it "returns false" do
        expect(submission).to_not be_collecting_final_submission_files
      end
    end
    context "when status is set to 'collecting final submission files'" do
      before { submission.status = "collecting final submission files" }
      it "returns true" do
        expect(submission).to be_collecting_final_submission_files
      end
    end
  end

  describe '#waiting_for_final_submission_response?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
      it "returns false" do
        expect(submission).to_not be_waiting_for_final_submission_response
      end
    end
    context "when status is set to 'waiting for final submission response'" do
      before { submission.status = "waiting for final submission response" }
      it "returns true" do
        expect(submission).to be_waiting_for_final_submission_response
      end
    end
  end

  describe '#waiting_for_publication_release?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
      it "returns false" do
        expect(submission).to_not be_waiting_for_publication_release
      end
    end
    context "when status is set to 'waiting for publication release'" do
      before { submission.status = "waiting for publication release" }
      it "returns true" do
        expect(submission).to be_waiting_for_publication_release
      end
    end
  end

  describe '#released_for_publication?' do
    context "when status is set to another valid value" do
      before { submission.status = 'collecting program information' }
      it "returns false" do
        expect(submission).to_not be_released_for_publication
      end
    end
    context "when status is set to 'released for publication'" do
      before { submission.status = "released for publication" }
      it "returns true" do
        expect(submission).to be_released_for_publication
      end
    end
  end

  describe '#beyond_collecting_committee?' do
    context "when status is beyond 'collecting committee'" do
      context "when status is 'collecting format review files'" do
        before { submission.status = 'collecting format review files' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_committee
        end
      end
      context "when status is 'waiting for format review response'" do
        before { submission.status = 'waiting for format review response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_committee
        end
      end
      context "when status is 'collecting final submission files'" do
        before { submission.status = 'collecting final submission files' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_committee
        end
      end
      context "when status is 'waiting for final submission response'" do
        before { submission.status = 'waiting for final submission response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_committee
        end
      end
      context "when status is 'waiting for publication release'" do
        before { submission.status = 'waiting for publication release' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_committee
        end
      end
      context "when status is 'released for publication'" do
        before { submission.status = 'waiting for final submission response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_committee
        end
      end
    end

    context "when status is before 'collecting format review files'" do
      context "when status is 'collecting program information'" do
        before { submission.status = 'collecting program information' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_committee
        end
      end
      context "when status is 'collecting committee'" do
        before { submission.status = 'collecting committee' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_committee
        end
      end
    end

  end

  describe '#beyond_collecting_format_review_files?' do
    context "when status is beyond 'collecting format review files'" do
      context "when status is 'waiting for format review response'" do
        before { submission.status = 'waiting for format review response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_format_review_files
        end
      end
      context "when status is 'collecting final submission files'" do
        before { submission.status = 'collecting final submission files' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_format_review_files
        end
      end
      context "when status is 'waiting for final submission response'" do
        before { submission.status = 'waiting for final submission response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_format_review_files
        end
      end
      context "when status is 'waiting for publication release'" do
        before { submission.status = 'waiting for publication release' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_format_review_files
        end
      end
      context "when status is 'released for publication'" do
        before { submission.status = 'waiting for final submission response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_format_review_files
        end
      end
    end

    context "when status is before 'waiting for format review response'" do
      context "when status is 'collecting program information'" do
        before { submission.status = 'collecting program information' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_format_review_files
        end
      end
      context "when status is 'collecting committee'" do
        before { submission.status = 'collecting committee' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_format_review_files
        end
      end
      context "when status is 'collecting format review files'" do
        before { submission.status = 'collecting format review files' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_format_review_files
        end
      end
    end
  end

  describe '#beyond_collecting_final_submission_files?' do
    context "when status is beyond 'collecting final submission files'" do
      context "when status is 'waiting for final submission response'" do
        before { submission.status = 'waiting for final submission response' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_final_submission_files
        end
      end
      context "when status is 'waiting for publication release'" do
        before { submission.status = 'waiting for publication release' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_final_submission_files
        end
      end
      context "when status is 'released for publication'" do
        before { submission.status = 'released for publication' }
        it "returns true" do
          expect(submission).to be_beyond_collecting_final_submission_files
        end
      end
    end
    context "when status is before 'collecting final submission files'" do
      context "when status is 'collecting program information'" do
        before { submission.status = 'collecting program information' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_final_submission_files
        end
      end
      context "when status is 'collecting committee'" do
        before { submission.status = 'collecting committee' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_final_submission_files
        end
      end
      context "when status is 'collecting format review files'" do
        before { submission.status = 'collecting format review files' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_final_submission_files
        end
      end
      context "when status is 'waiting for format review response'" do
        before { submission.status = 'waiting for format review response' }
        it "returns false" do
          expect(submission).to_not be_beyond_collecting_final_submission_files
        end
      end
    end
  end

  describe '#beyond_waiting_for_final_submission_response?' do
    context "when status is beyond 'waiting for final submission response'" do
      context "when status is 'waiting for publication release'" do
        before { submission.status = 'waiting for publication release' }
        it "returns true" do
          expect(submission).to be_beyond_waiting_for_final_submission_response
        end
      end
      context "when status is 'released for publication'" do
        before { submission.status = 'released for publication' }
        it "returns true" do
          expect(submission).to be_beyond_waiting_for_final_submission_response
        end
      end
    end

    context "when status is before 'waiting for final submission response'" do
      context "when status is 'collecting program information'" do
        before { submission.status = 'collecting program information' }
        it "returns false" do
          expect(submission).to_not be_beyond_waiting_for_final_submission_response
        end
      end
      context "when status is 'collecting committee'" do
        before { submission.status = 'collecting committee' }
        it "returns false" do
          expect(submission).to_not be_beyond_waiting_for_final_submission_response
        end
      end
      context "when status is 'collecting format review files'" do
        before { submission.status = 'collecting format review files' }
        it "returns false" do
          expect(submission).to_not be_beyond_waiting_for_final_submission_response
        end
      end
      context "when status is 'waiting for format review response'" do
        before { submission.status = 'waiting for format review response' }
        it "returns false" do
          expect(submission).to_not be_beyond_waiting_for_final_submission_response
        end
      end
      context "when status is 'collecting final submission files'" do
        before { submission.status = 'collecting final submission files' }
        it "returns false" do
          expect(submission).to_not be_beyond_waiting_for_final_submission_response
        end
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

end
