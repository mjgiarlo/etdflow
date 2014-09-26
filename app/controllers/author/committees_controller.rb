class Author::CommitteesController < AuthorController

  def new 
    submission = @author.submissions.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(submission)
    status_giver.can_provide_new_committee?
    @committee = Committee.new(committee_members: Committee.members(submission))
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end 

  def create
    submission = @author.submissions.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(submission)
    status_giver.can_provide_new_committee?
    @committee = Committee.new(params[:committee])
    @committee.save
    status_giver.collecting_format_review_files!
    submission.update_attribute :committee_provided_at, Time.zone.now
    flash[:notice] = 'Committee saved successfully'
    redirect_to author_root_path
  rescue Committee::InvalidCommitteeError
    render :new
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  rescue SubmissionStatusGiver::InvalidTransition
    redirect_to author_root_path
    flash[:alert] = 'Oops! You may have submitted invalid committee information. Please double check your committee.'
  end 

  def edit
    @submission = @author.submissions.find(params[:submission_id])
    @committee = Committee.new(committee_members: @submission.committee_members)
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_update_committee?
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

  def update
    @submission = @author.submissions.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_update_committee?
    @committee = Committee.new(params[:committee])
    @committee.update(params[:committee])
    flash[:notice] = 'Committee updated successfully'
    redirect_to author_root_path
  rescue Committee::InvalidCommitteeError
    render :edit
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

end
