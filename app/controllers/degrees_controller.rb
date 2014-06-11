class DegreesController < ApplicationController

  def index
    @degrees = Degree.all
  end

end
