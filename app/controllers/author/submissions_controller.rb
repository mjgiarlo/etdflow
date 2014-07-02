class Author::SubmissionsController < ApplicationController

  def index
  end

  def new
    @Submission = Submission.new
  end

  def create
    redirect_to author_submissions_path
  end

end
