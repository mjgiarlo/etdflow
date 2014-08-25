class Author::SubmissionsController < AuthorController

  def index
    @view = SubmissionsIndexView.new(@author)
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.save!
    @submission.collecting_committee!
    redirect_to author_root_path
    flash[:notice] = 'Program information saved successfully'
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    @submission.update_attributes!(submission_params)
    redirect_to author_root_path
    flash[:notice] = 'Program information updated successfully'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_author_submission_path(@submission)
    flash[:notice] = e.message
  end

  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy
    flash[:notice] = "Submission deleted successfully."
    redirect_to author_root_path
  rescue
    flash[:notice] = "Can not delete submission."
    redirect_to author_root_path
  end

  def format_review
    @submission = Submission.find(params[:submission_id])
  end

  private

  def submission_params
    params.require(:submission).permit(:semester,
                                       :year,
                                       :author_id,
                                       :program_id,
                                       :degree_id)
  end

end
