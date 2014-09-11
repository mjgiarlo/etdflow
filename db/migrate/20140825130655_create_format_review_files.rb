class CreateFormatReviewFiles < ActiveRecord::Migration
  def change
    create_table :format_review_files do |t|
      t.integer :submission_id
      t.text :filename

      t.timestamps
    end
  end
end
