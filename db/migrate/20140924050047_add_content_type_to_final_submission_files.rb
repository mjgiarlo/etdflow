class AddContentTypeToFinalSubmissionFiles < ActiveRecord::Migration
  def change
    add_column :final_submission_files, :content_type, :string
  end
end
