class Author::SubmissionsController < AuthorController

  def index
    @view = Author::SubmissionsIndexView.new(@author)
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(program_information_params)
    @submission.save!
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.collecting_committee!
    redirect_to author_root_path
    flash[:notice] = 'Program information saved successfully'
  rescue ActiveRecord::RecordInvalid
    render :new
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to author_root_path
    flash[:alert] = 'Oops! You may have submitted invalid program information data. Please check that your program information is correct.'
  end

  def edit
    @submission = Submission.find(params[:id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_update_program_information?
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

  def update
    @submission = Submission.find(params[:id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_update_program_information?
    @submission.update_attributes!(program_information_params)
    redirect_to author_root_path
    flash[:notice] = 'Program information updated successfully'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_author_submission_path(@submission)
    flash[:alert] = e.message
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy
    flash[:notice] = "Submission deleted successfully."
    redirect_to author_root_path
  rescue
    flash[:alert] = "Can not delete submission."
    redirect_to author_root_path
  end

  def edit_format_review
    @submission = Submission.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_upload_format_review_files?
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

  def update_format_review
    @submission = Submission.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_upload_format_review_files?
    @submission.update_attributes!(format_review_params)
    status_giver.waiting_for_format_review_response!
    redirect_to author_root_path
    flash[:notice] = 'Format review files uploaded successfully.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to author_submission_format_review_path(@submission)
    flash[:alert] = e.message
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to author_root_path
    flash[:alert] = 'Oops! You may have submitted invalid format review data. Please check that your format review information is correct.'
  end

  def final_submission
    @submission = Submission.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_upload_final_submission_files?
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

  def update_final_submission
    @submission = Submission.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_upload_final_submission_files?
    @submission.update_attributes!(final_submission_params)
    status_giver.waiting_for_final_submission_response!
    redirect_to author_root_path
    flash[:notice] = 'Final submission files uploaded successfully.'
  rescue ActiveRecord::RecordInvalid
    render :final_submission
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to author_root_path
    flash[:alert] = 'Oops! You may have submitted invalid format review data. Please check that your format review information is correct.'
  end

  private

  def program_information_params
    params.require(:submission).permit(:semester,
                                       :year,
                                       :author_id,
                                       :program_id,
                                       :degree_id,
                                       :title)
  end

  def format_review_params
    params.require(:submission).permit(:title,
                                       format_review_files_attributes: [:filename, :submission_id, :id, :_destroy])
  end

  def final_submission_params
    params.require(:submission).permit(:defended_at,
                                       :abstract,
                                       :keywords,
                                       :access_level,
                                       :has_agreed_to_terms,
                                       final_submission_files_attributes: [:filename, :submission_id, :id, :_destroy])
  end

end
