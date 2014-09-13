class CreateFinalSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :final_submission_files do |t|
      t.integer :submission_id
      t.text :filename

      t.timestamps
    end
  end
end
