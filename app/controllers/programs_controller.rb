class ProgramsController < ApplicationController

  def index
    @programs = Program.all
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)
    @program.save!
    flash[:success] = 'Program created'
    redirect_to programs_path
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
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_program_path(@program)
  end

  private

  def program_params
    params.require(:program).permit(:description,
                                    :is_active  )
  end

end
