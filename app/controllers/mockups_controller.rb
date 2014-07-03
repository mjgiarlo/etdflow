class MockupsController < ApplicationController

  def show
    @author = Author.new
    render params[:page]
  end

end
