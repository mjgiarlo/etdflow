module CommitteeFactory

  def create_committee(submission)
    Committee.new(committee_members: committee_members)
  end

  def committee_members
    members = []
    members << ( create :committee_member, :advisor, submission: submission )
    Committee.additional_roles.count.times do
      members << ( create :committee_member, submission: submission )
    end 
    members
  end 
end

RSpec.configure do |config|
  config.include CommitteeFactory
end
