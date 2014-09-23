class Admin::SubmissionsController < AdminController

  def dashboard
    @view = Admin::SubmissionsDashboardView.new(params[:degree_type])
  end

  def edit
    @submission = Submission.find(params[:id])
    @view = Admin::SubmissionFormView.new(@submission)
  end

  def index
    session[:return_to] = request.referer
    @view = Admin::SubmissionsIndexView.new(params[:degree_type], params[:scope])
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
  rescue SubmissionStatusGiver::AccessForbidden
    flash[:alert] = 'There was a problem releasing the submissions, please try again.'
    redirect_to session.delete(:return_to)
  end

  def record_format_review_response
    @submission = Submission.find(params[:id])
    if params[:approved]
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.can_respond_to_format_review?
      @submission.update_attributes!(format_review_params)
      status_giver.collecting_final_submission_files!
      @submission.update_attribute :format_review_approved_at, Time.zone.now
      redirect_to admin_submissions_index_path(@submission.parameterized_degree_type, 'format_review_submitted')
      flash[:notice] = 'The submission\'s format review information was successfully approved and returned to the author to collect final submission information.'
    end
    if params[:rejected]
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.can_respond_to_format_review?
      @submission.update_attributes!(format_review_params)
      status_giver.collecting_format_review_files!
      @submission.update_attribute :format_review_rejected_at, Time.zone.now
      redirect_to admin_submissions_index_path(@submission.parameterized_degree_type, 'format_review_submitted')
      flash[:notice] = 'The submission\'s format review information was successfully rejected and returned to the author for revision.'
    end
  rescue ActiveRecord::RecordInvalid
    render :edit
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to session.delete(:return_to)
    flash[:alert] = 'This submission\'s format review information has already been evaluated.'
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to session.delete(:return_to)
    flash[:alert] = 'Oops! You may have submitted invalid format review data. Please check that the submission\'s format review information is correct.'
  end

  def record_final_submission_response
    @submission = Submission.find(params[:id])
    if params[:approved]
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.can_respond_to_final_submission?
      @submission.update_attributes!(final_submission_params)
      status_giver.waiting_for_publication_release!
      @submission.update_attribute :final_submission_approved_at, Time.zone.now
      redirect_to admin_submissions_index_path(@submission.parameterized_degree_type, 'final_submission_submitted')
      flash[:notice] = 'The submission\'s final submission information was successfully approved.'
    end
    if params[:rejected]
      status_giver = SubmissionStatusGiver.new(@submission)
      status_giver.can_respond_to_final_submission?
      @submission.update_attributes!(final_submission_params)
      status_giver.collecting_final_submission_files!
      @submission.update_attribute :final_submission_rejected_at, Time.zone.now
      redirect_to admin_submissions_index_path(@submission.parameterized_degree_type, 'final_submission_submitted')
      flash[:notice] = 'The submission\'s final submission information was successfully rejected and returned to the author for revision.'
    end
  rescue ActiveRecord::RecordInvalid
    render :edit
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to session.delete(:return_to)
    flash[:alert] = 'This submission\'s final submission information has already been evaluated.'
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to session.delete(:return_to)
    flash[:alert] = 'Oops! You may have submitted invalid final submission data. Please check that the submission\'s final submission information is correct.'
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
