class Author::PapersController < ApplicationController

  def index
  end

  def new
    @paper = Paper.new
  end

  def create
    redirect_to author_dashboard_path
  end

end