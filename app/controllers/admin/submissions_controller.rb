class Admin::SubmissionsController < AdminController

  def dashboard
    degree_type_scope = params[:degree_type]
    @submissions = Submission.send degree_type_scope
  end

end
