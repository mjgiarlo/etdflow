class AddRemainingFieldsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :format_review_notes, :text
    add_column :submissions, :final_submission_notes, :text
    add_column :submissions, :defended_at, :datetime
    add_column :submissions, :abstract, :text
    add_column :submissions, :keywords, :text
    add_column :submissions, :access_level, :string
    add_column :submissions, :has_agreed_to_terms, :boolean
  end
end
