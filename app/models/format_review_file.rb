class FormatReviewFile < ActiveRecord::Base

  mount_uploader :asset, SubmissionFileUploader

  validates :submission_id, :asset, presence: true

  belongs_to :submission

  def class_name
    self.class.to_s.underscore.dasherize
  end

end
