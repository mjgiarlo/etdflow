class AddTransitionTimestampsToSubmissionss < ActiveRecord::Migration
  change_table :submissions do |t|
    t.datetime :committee_provided_at
    t.datetime :format_review_files_uploaded_at
    t.datetime :format_review_rejected_at
    t.datetime :format_review_approved_at
    t.datetime :final_submission_files_uploaded_at
    t.datetime :final_submission_rejected_at
    t.datetime :final_submission_approved_at
    t.datetime :released_for_publication_at
  end
end
