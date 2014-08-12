class Admin::SubmissionsController < AdminController

  def dashboard
    @view = Admin::SubmissionsDashboardView.new(params[:degree_type])
  end

end
