require 'component/component_spec_helper'

describe Committee do

  let!(:submission) { create :submission }

  describe '.advisor' do
    it 'returns the configured advisor role' do
      expect(Committee.advisor).to eq Etdflow::Application.config.committee_advisor_role 
    end
  end

  describe '.additional_roles' do
   
    it 'returns the remaining configured roles' do
      configured_roles = Etdflow::Application.config.committee_other_required_roles
      Committee.additional_roles.each_with_index do |role, i|
        expect(configured_roles[i]).to eq role
      end
    end
  end

  describe '.members' do
    it 'Defines the structure of the committee' do
      advisor = Etdflow::Application.config.committee_advisor_role
      additional_roles = Etdflow::Application.config.committee_other_required_roles

      cm = Committee.members(submission)

      expect(cm[0].role).to eq advisor
      expect(cm[0].is_advisor).to be_true

      additional_roles.each_with_index do |member_role, i|
        expect(cm[i+1].role).to eq member_role
        expect(cm[i+1].is_advisor).to be_false
      end
    end
  end

  describe '#save' do
    let(:invalid_committee) { Committee.new(committee_members: Committee.members(submission)) }
    let(:valid_committee) { create_committee(submission) }
    it 'saves a valid committee' do
      valid_committee.save
      expect(CommitteeMember.count).to eq Committee.additional_roles.count + 1
    end
    it 'returns an error for an invalid committee and does not save any members' do
      expect{ invalid_committee.save }.to raise_error Committee::InvalidCommitteeError
      expect(CommitteeMember.count).to eq 0
    end
  end
end
