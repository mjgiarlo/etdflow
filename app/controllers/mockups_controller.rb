class MockupsController < ApplicationController

  def show
    render params[:page]
  end

end