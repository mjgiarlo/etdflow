class Admin::SubmissionsController < AdminController

  def dashboard
    @view = Admin::SubmissionsDashboardView.new(params[:degree_type])
  end

  def format_review_incomplete
    @submissions = Submission.format_review_is_incomplete
  end

end
