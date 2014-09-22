class Admin::SubmissionsController < AdminController

  def dashboard
    @view = Admin::SubmissionsDashboardView.new(params[:degree_type])
  end

  def edit
    @submission = Submission.find(params[:id])
    @view = Admin::SubmissionFormView.new(@submission)
  end

  def format_review_incomplete
    session[:return_to] = request.referer
    @submissions = Submission.send(params[:degree_type]).format_review_is_incomplete
  end

  def format_review_submitted
    session[:return_to] = request.referer
    @submissions = Submission.send(params[:degree_type]).format_review_is_submitted
  end

  def final_submission_incomplete
    session[:return_to] = request.referer
    @submissions = Submission.send(params[:degree_type]).final_submission_is_incomplete
  end

  def final_submission_submitted
    session[:return_to] = request.referer
    @submissions = Submission.send(params[:degree_type]).final_submission_is_submitted
  end

  def final_submission_approved
    session[:return_to] = request.referer
    @submissions = Submission.send(params[:degree_type]).final_submission_is_approved
  end

  def released_for_publication
    session[:return_to] = request.referer
    @submissions = Submission.send(params[:degree_type]).released_for_publication
  end

  def bulk_destroy
    ids = params[:submission_ids].split(',')
    Submission.destroy(ids)
    flash[:notice] = 'Submissions deleted successfully'
    redirect_to session.delete(:return_to)
  rescue
    flash[:alert] = 'There was a problem deleting your submissions'
    redirect_to session.delete(:return_to)
  end

  def release_for_publication
    ids = params[:submission_ids].split(',')
    Submission.release_for_publication(ids)
    flash[:notice] = 'Submissions released successfully'
    redirect_to admin_submissions_dashboard_path(params[:degree_type])
  rescue
    flash[:alert] = 'There was a problem releasing the submissions'
    redirect_to admin_submissions_dashboard_path(params[:degree_type])
  end

  def record_format_review_response
    @submission = Submission.find(params[:id])
    if params[:approved]
      @submission.update_attributes!(format_review_params)
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.collecting_final_submission_files!
      @submission.update_attribute :format_review_approved_at, Time.zone.now
      redirect_to admin_submissions_format_review_submitted_path(@submission.parameterized_degree_type)
      flash[:notice] = 'The submission\'s format review information was successfully approved and returned to the author to collect final submission information.'
    end
    if params[:rejected]
      @submission.update_attributes!(format_review_params)
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.collecting_format_review_files!
      @submission.update_attribute :format_review_rejected_at, Time.zone.now
      redirect_to admin_submissions_format_review_submitted_path(@submission.parameterized_degree_type)
      flash[:notice] = 'The submission\'s format review information was successfully rejected and returned to the author for revision.'
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

  def record_final_submission_response
    @submission = Submission.find(params[:id])
    if params[:approved]
      @submission.update_attributes!(final_submission_params)
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.waiting_for_publication_release!
      @submission.update_attribute :final_submission_approved_at, Time.zone.now
      redirect_to admin_submissions_final_submission_submitted_path(@submission.parameterized_degree_type)
      flash[:notice] = 'The submission\'s final submission information was successfully approved.'
    end
    if params[:rejected]
      @submission.update_attributes!(final_submission_params)
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.collecting_final_submission_files!
      @submission.update_attribute :final_submission_rejected_at, Time.zone.now
      redirect_to admin_submissions_final_submission_submitted_path(@submission.parameterized_degree_type)
      flash[:notice] = 'The submission\'s final submission information was successfully rejected and returned to the author for revision.'
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

  def final_submission_params
    params.require(:submission).permit(:semester,
                                       :year,
                                       :author_id,
                                       :program_id,
                                       :degree_id,
                                       :title,
                                       :format_review_notes,
                                       :final_submission_notes,
                                       :defended_at,
                                       :abstract,
                                       :keywords,
                                       :access_level,
                                       committee_members_attributes: [:role, :name, :email, :is_advisor, :id],
                                       format_review_files_attributes: [:filename, :id, :_destroy],
                                       final_submission_files_attributes: [:filename, :id, :_destroy])
  end

end
