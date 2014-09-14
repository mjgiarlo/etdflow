class FormatReviewFile < ActiveRecord::Base

  validates :submission_id, :filename, presence: true

  belongs_to :submission

  mount_uploader :filename, SubmissionFileUploader

  def class_name
    self.class.to_s.underscore.dasherize
  end

end
