class ProgramsController < ApplicationController

  def index
    @programs = Program.all
    respond_to do |format|
      format.html
      format.json {
        @programs_map = @programs.map do |p|
          [
            "<a href=#{edit_program_path(p)}>#{p.name}</a>",
            p.active_status
          ]
        end
        @programs_json = { data: @programs_map }
        render json: @programs_json
      }
    end
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)
    @program.save!
    redirect_to programs_path
    flash[:notice] = 'Program successfully created'
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    @program = Program.find(params[:id])
  end

  def update
    @program = Program.find(params[:id])
    @program.update_attributes!(program_params)
    redirect_to programs_path
    flash[:notice] = 'Program successfully updated'
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_program_path(@program)
  end

  private

  def program_params
    params.require(:program).permit(:name,
                                    :is_active  )
  end

end
