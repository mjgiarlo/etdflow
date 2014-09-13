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
    {
        title: 'Format Review is Incomplete',
        description: 'Submissions whose format review has not yet been submitted or whose format review is currently rejected.',
        path: submissions.empty? ? nil : "/admin/#{@degree_type}/format_review_incomplete",
        count: submissions.empty? ? nil : submissions.count.to_s
    }
  end

  def format_review_is_submitted_filter
    submissions = Submission.send(@degree_type).format_review_is_submitted
    {
        title: 'Format Review is Submitted',
        description: 'Submissions whose format review is currently waiting to be approved or rejected.',
        path: submissions.empty? ? nil : "/admin/#{@degree_type}/format_review_submitted",
        count: submissions.empty? ? nil : submissions.count.to_s
    }
  end

  def final_submission_is_incomplete
    submissions = Submission.send(@degree_type).final_submission_is_incomplete
    {
        title: 'Final Submission is Incomplete',
        description: 'Submissions whose format review information has been approved, but whose final submission information has not yet been submitted or whose final submission information is currently rejected.',
        path: submissions.empty? ? nil : "/admin/#{@degree_type}/final_submission_incomplete",
        count: submissions.empty? ? nil : submissions.count.to_s
    }
  end

end
