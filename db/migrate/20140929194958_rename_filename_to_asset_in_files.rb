class RenameFilenameToAssetInFiles < ActiveRecord::Migration
  def change
    rename_column :format_review_files, :filename, :asset
    rename_column :final_submission_files, :filename, :asset
  end
end
