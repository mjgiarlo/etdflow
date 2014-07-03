class Author::SubmissionsController < AuthorController

  def index
    @view = SubmissionsIndexView.new(@author)
  end

  def new
    @submission = Submission.new
  end

  def create
    redirect_to author_submissions_path
  end

end
