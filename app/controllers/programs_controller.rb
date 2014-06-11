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

  private

  def program_params
    params.require(:program).permit(:description,
                                    :is_active  )
  end

end
