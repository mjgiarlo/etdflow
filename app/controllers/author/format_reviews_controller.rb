class Author::FormatReviewsController < AuthorController

  def new 
    submission = Submission.find(params[:submission_id])
    @format_review = FormatReview.new
  end 

  def create
    submission = Submission.find(params[:submission_id])
    submission.waiting_for_format_review_response!
    @format_review = FormatReview.new
    @format_review.save(params[:format_review][:files])
    flash[:notice] = "Your files were uploaded successfully"
    redirect_to author_root_path
  end 

end
