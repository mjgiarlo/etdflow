class Admin::SubmissionsDashboardView

  def initialize(degree_type)
    @degree_type = degree_type
  end

  def title
    @degree_type.titleize
  end

  def filters
    [
      format_review_is_incomplete_filter
    ]
  end

  private

  def format_review_is_incomplete_filter
    submissions = Submission.send(@degree_type).format_review_is_incomplete
    ("<a href='" + "/admin/#{@degree_type}/format_review_incomplete" + "'> Format Review is Incomplete <span>" + submissions.count.to_s + "</span></a>").html_safe unless submissions.empty?
  end

end
