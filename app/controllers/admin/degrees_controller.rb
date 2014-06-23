class Admin::DegreesController < ApplicationController

  def index
    @degrees = Degree.all
  end

  def new
    @degree = Degree.new
  end

  def create
    @degree = Degree.new(degree_params)
    @degree.save!
    redirect_to admin_degrees_path
    flash[:notice] = 'Degree successfully created'
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    @degree = Degree.find(params[:id])
  end

  def update
    @degree = Degree.find(params[:id])
    @degree.update_attributes!(degree_params)
    redirect_to admin_degrees_path
    flash[:notice] = 'Degree successfully updated'
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_admin_degree_path(@degree)
  end

  private

  def degree_params
    params.require(:degree).permit(:name,
                                   :description,
                                   :degree_type,
                                   :is_active  )
  end

end