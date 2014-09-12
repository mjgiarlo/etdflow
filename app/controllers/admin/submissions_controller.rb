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

  def final_submission_incomplete
    @submissions = Submission.send(params[:degree_type]).final_submission_is_incomplete
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

  def record_format_review_response
    @submission = Submission.find(params[:id])
    if params[:approved]
      @submission.update_attributes!(format_review_params)
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.collecting_final_submission_files!
      redirect_to admin_submissions_format_review_submitted_path(@submission.parameterized_degree_type)
      flash[:notice] = 'Approval was successful.'
    end
  rescue ActiveRecord::RecordInvalid
    render :edit
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to author_root_path
    flash[:alert] = 'Oops! You may have submitted invalid format review data. Please check that your format review information is correct.'
  end

  private

  def format_review_params
    params.require(:submission).permit(:semester,
                                       :year,
                                       :author_id,
                                       :program_id,
                                       :degree_id,
                                       :title,
                                       :format_review_notes,
                                       committee_members_attributes: [:role, :name, :email, :is_advisor, :id],
                                       format_review_files_attributes: [:filename, :id, :_destroy])
  end

end
