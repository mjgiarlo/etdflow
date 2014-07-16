class Committee
  class InvalidCommitteeError < Exception; end

  include ActiveModel::Model

  attr_accessor :committee_members

  def self.advisor
    Etdflow::Application.config.committee_advisor_role
  end

  def self.additional_roles
    Etdflow::Application.config.committee_other_required_roles
  end

  def self.members(submission)
    members = []
    members << CommitteeMember.new(role: Committee.advisor, is_advisor: true, submission: submission)
    Committee.additional_roles.each do |role|
      members << CommitteeMember.new(role: role, is_advisor: false, submission: submission)
    end
    members
  end

  def committee_members_attributes=(attributes)
    @committee_members ||= []
    attributes.each do |i, committee_member_params|
      @committee_members.push(CommitteeMember.new(committee_member_params))
    end
  end

  def save
    if is_valid?
      CommitteeMember.transaction do
        @committee_members.each do |cm|
          cm.save!
        end
      end
    else
      raise InvalidCommitteeError
    end
  end

  private

  def is_valid?
    result = true
    @committee_members.each do |cm|
      result = false unless cm.valid?
    end
    result
  end

end
