class DegreesController < ApplicationController

  def index
    @degrees = Degree.all
    respond_to do |format|
      format.html
      format.json {
        @degrees_map = @degrees.map do |d|
          [
              "<a href=#{edit_degree_path(d)}>#{d.name}</a>",
              d.description,
              d.degree_type,
              d.active_status
          ]
        end
        @degrees_json = { data: @degrees_map }
        render json: @degrees_json
      }
    end
  end

  def new
    @degree = Degree.new
  end

  def create
    @degree = Degree.new(degree_params)
    @degree.save!
    redirect_to degrees_path
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
    redirect_to degrees_path
    flash[:notice] = 'Degree successfully updated'
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_degree_path(@degree)
  end

  private

  def degree_params
    params.require(:degree).permit(:name,
                                   :description,
                                   :degree_type,
                                   :is_active  )
  end

end
