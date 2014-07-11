class CommitteeMember < ActiveRecord::Base

  validates :submission_id,
            :role,
            :name,
            :email,
            :is_advisor, presence: true

  belongs_to :submission

end
