class Admin::SubmissionsDashboardView

  def initialize(degree_type)
    @degree_type = degree_type
  end

  def title
    @degree_type.titleize
  end

  def filters
    [
      ("<a href='" + "#{@degree_type}/format_review_incomplete" + "'> Format Review is Incomplete <span>2</span></a>").html_safe
    ]
  end

end
