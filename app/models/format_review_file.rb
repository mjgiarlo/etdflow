class FormatReviewFile < ActiveRecord::Base

  validates :submission_id, :filename, Presence: true

  belongs_to :submission

end
