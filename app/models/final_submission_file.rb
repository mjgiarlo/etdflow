class FinalSubmissionFile < ActiveRecord::Base
  before_save :update_filename_attributes

  validates :submission_id, :filename, presence: true

  belongs_to :submission

  mount_uploader :filename, SubmissionFileUploader

  def class_name
    self.class.to_s.underscore.dasherize
  end

  private

  def update_filename_attributes
    if filename.present? && filename_changed?
    # self.content_type = filename.file.content_type
    end
  end
end
