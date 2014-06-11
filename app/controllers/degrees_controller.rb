class DegreesController < ApplicationController

  def index
    @degrees = Degree.all
  end

  def new
    @degree = Degree.new
  end

  def create
    @degree = Degree.new(degree_params)
    @degree.save!
    flash[:success] = 'Degree created'
    redirect_to degrees_path
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def degree_params
    params.require(:degree).permit(:name,
                                   :description,
                                   :degree_type,
                                   :is_active  )
  end

end
