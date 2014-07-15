class Author::CommitteesController < AuthorController

  def new 
    submission = Submission.find(params[:submission_id])
    @committee = Committee.new(committee_members: Committee.members(submission))
  end 

  def create
    @committee = Committee.new(params[:committee])
    @committee.save
    flash[:notice] = 'Committee saved successfully'
    redirect_to author_root_path
  rescue Committee::InvalidCommitteeError
    render :new
  end 

end
