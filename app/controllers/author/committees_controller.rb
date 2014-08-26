class Author::CommitteesController < AuthorController

  def new 
    submission = Submission.find(params[:submission_id])
    @committee = Committee.new(committee_members: Committee.members(submission))
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
  end

  def update
    @submission = Submission.find(params[:submission_id])
    @committee = Committee.new(params[:committee])
    @committee.update(params[:committee])
    flash[:notice] = 'Committee updated successfully'
    redirect_to author_root_path
  rescue Committee::InvalidCommitteeError
    render :edit
  end

end
