class FormatReviewFile < ActiveRecord::Base

  validates :submission_id, :filename, Presence: true

  belongs_to :submission

  mount_uploader :filename, FormatReviewFileUploader

end
