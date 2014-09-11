class Admin::SubmissionsController < AdminController

  def dashboard
    @view = Admin::SubmissionsDashboardView.new(params[:degree_type])
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def format_review_incomplete
    @submissions = Submission.send(params[:degree_type]).format_review_is_incomplete
  end

  def format_review_submitted
    @submissions = Submission.send(params[:degree_type]).format_review_is_submitted
  end

  def bulk_destroy
    ids = params[:submission_ids].split(',')
    Submission.destroy(ids)
    flash[:notice] = 'Submissions deleted successfully'
    redirect_to admin_submissions_format_review_incomplete_path(params[:degree_type])
  rescue
    flash[:alert] = 'There was a problem deleting your submissions'
    redirect_to admin_submissions_format_review_incomplete_path(params[:degree_type])
  end

end
