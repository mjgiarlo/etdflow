class CommitteeMember < ActiveRecord::Base

  validates :submission_id,
            :role,
            :name,
            :email, presence: true

  belongs_to :submission

end
