class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "committee_members", "submissions", name: "committee_members_submission_id_fk", dependent: :delete
    add_foreign_key "final_submission_files", "submissions", name: "final_submission_files_submission_id_fk", dependent: :delete
    add_foreign_key "format_review_files", "submissions", name: "format_review_files_submission_id_fk", dependent: :delete
    add_foreign_key "submissions", "authors", name: "submissions_author_id_fk", dependent: :delete
    add_foreign_key "submissions", "degrees", name: "submissions_degree_id_fk"
    add_foreign_key "submissions", "programs", name: "submissions_program_id_fk"
  end
end
