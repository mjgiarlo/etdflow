class Author::FormatReviewsController < AuthorController

  def new 
    submission = Submission.find(params[:submission_id])
    @format_review = FormatReview.new
  end 

  def create
  end 

end
