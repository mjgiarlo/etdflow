class Author::CommitteesController < AuthorController

  def new 
    submission = Submission.find(params[:submission_id])
    status_giver = SubmissionStatusGiver.new(submission)
    status_giver.can_provide_new_committee?
    @committee = Committee.new(committee_members: Committee.members(submission))
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end 

  def create
    submission = Submission.find(params[:submission_id])
    @committee = Committee.new(params[:committee])
    @committee.save
    status_giver = SubmissionStatusGiver.new(submission)
    status_giver.collecting_format_review_files!
    flash[:notice] = 'Committee saved successfully'
    redirect_to author_root_path
  rescue Committee::InvalidCommitteeError
    render :new
  end 

  def edit
    @submission = Submission.find(params[:submission_id])
    @committee = Committee.new(committee_members: @submission.committee_members)
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.can_update_committee?
  rescue SubmissionStatusGiver::AccessForbidden
    redirect_to author_root_path
    flash[:alert] = 'You are not allowed to visit that page at this time, please contact your administrator'
  end

  def update
    @submission = Submission.find(params[:submission_id])
    @committee = Committee.new(params[:committee])
    @committee.update(params[:committee])
    flash[:notice] = 'Committee updated successfully'
    status_giver = SubmissionStatusGiver.new(@submission)
    status_giver.collecting_format_review_files!
    redirect_to author_root_path
  rescue Committee::InvalidCommitteeError
    render :edit
  end

end
