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
    redirect_to author_root_path
    flash[:notice] = 'Program information saved successfully'
  rescue ActiveRecord::RecordInvalid
    render :new
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

  private

  def submission_params
    params.require(:submission).permit(:semester,
                                       :year,
                                       :author_id,
                                       :program_id,
                                       :degree_id)
  end

end
