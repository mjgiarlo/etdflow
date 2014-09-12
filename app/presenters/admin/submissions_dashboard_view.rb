class Admin::SubmissionsDashboardView

  def initialize(degree_type)
    @degree_type = degree_type
  end

  def title
    @degree_type.titleize
  end

  def filters
    [
      format_review_is_incomplete_filter,
      format_review_is_submitted_filter,
      final_submission_is_incomplete
    ]
  end

  private

  def format_review_is_incomplete_filter
    submissions = Submission.send(@degree_type).format_review_is_incomplete
    if submissions.empty?
     ("<div class='panel panel-default no-submissions'><div class='panel-heading'><h3 class='panel-title'>Format Review is Incomplete <span class='badge pull-right'>0</span></h3></div><div class='panel-body'>Submissions whose format review has not yet been submitted or whose format review is currently rejected.</div></div>").html_safe
    else
      ("<a href='" + "/admin/#{@degree_type}/format_review_incomplete" + "' class='panel panel-default filter'><div class='panel-heading'><h3 class='panel-title'>Format Review is Incomplete <span class='badge pull-right'>" + submissions.count.to_s + "</span></h3></div><div class='panel-body'>Submissions whose format review has not yet been submitted or whose format review is currently rejected.</div></a>").html_safe
    end
  end

  def format_review_is_submitted_filter
    submissions = Submission.send(@degree_type).format_review_is_submitted
    if submissions.empty?
      ("<div class='panel panel-default no-submissions'><div class='panel-heading'><h3 class='panel-title'>Format Review is Submitted <span class='badge pull-right'>0</span></h3></div><div class='panel-body'>Submissions whose format review is currently waiting to be approved or rejected.</div></div>").html_safe
    else
      ("<a href='" + "/admin/#{@degree_type}/format_review_submitted" + "' class='panel panel-default filter'><div class='panel-heading'><h3 class='panel-title'>Format Review is Submitted <span class='badge pull-right'>" + submissions.count.to_s + "</span></h3></div><div class='panel-body'>Submissions whose format review is currently waiting to be approved or rejected.</div></a>").html_safe
    end
  end

  def final_submission_is_incomplete
    submissions = Submission.send(@degree_type).final_submission_is_incomplete
    if submissions.empty?
      ("<div class='panel panel-default no-submissions'><div class='panel-heading'><h3 class='panel-title'>Final Submission is Incomplete <span class='badge pull-right'>0</span></h3></div><div class='panel-body'>Submissions whose format review information has been approved, but whose final submission information has not yet been submitted or whose final submission information is currently rejected.</div></div>").html_safe
    else
      ("<a href='" + "/admin/#{@degree_type}/final_submission_incomplete" + "' class='panel panel-default filter'><div class='panel-heading'><h3 class='panel-title'>Final Submission is Incomplete <span class='badge pull-right'>" + submissions.count.to_s + "</span></h3></div><div class='panel-body'>Submissions whose final submission information has not yet been submitted or whose final submission information is currently rejected.</div></a>").html_safe
    end
  end

end
