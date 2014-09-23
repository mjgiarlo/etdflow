class Admin::SubmissionsIndexView
  attr_reader :submissions

  def initialize(degree_type, scope)
    @degree_type = degree_type
    @scope = scope
    @submissions = Submission.send(degree_type).send(scope_method)
  end

  def title
    if format_review_incomplete?
      'Format Review is Incomplete'
    elsif format_review_submitted?
      'Format Review is Submitted'
    elsif final_submission_incomplete?
      'Final Submission is Incomplete'
    elsif final_submission_submitted?
      'Final Submission is Submitted'
    elsif final_submission_approved?
      'Final Submission is Approved'
    else
      'Released eTDs'
    end
  end

  def id
    if format_review_incomplete?
      'incomplete-format-review-submissions-index'
    elsif format_review_submitted?
      'submitted-format-review-submissions-index'
    elsif final_submission_incomplete?
      'incomplete-final-submission-submissions-index'
    elsif final_submission_submitted?
      'submitted-final-submission-submissions-index'
    elsif final_submission_approved?
      'approved-final-submission-submissions-index'
    else
      'released-for-publication-submissions-index'
    end
  end

  def render_release_for_publication_button?
    final_submission_approved?
  end

  private

  def format_review_incomplete?
    @scope == 'format_review_incomplete'
  end

  def format_review_submitted?
    @scope == 'format_review_submitted'
  end

  def final_submission_incomplete?
    @scope == 'final_submission_incomplete'
  end

  def final_submission_submitted?
    @scope == 'final_submission_submitted'
  end

  def final_submission_approved?
    @scope == 'final_submission_approved'
  end

  def released_for_publication?
    @scope == 'released_for_publication'
  end

  def scope_method
    if format_review_incomplete?
      'format_review_is_incomplete'
    elsif format_review_submitted?
      'format_review_is_submitted'
    elsif final_submission_incomplete?
      'final_submission_is_incomplete'
    elsif final_submission_submitted?
      'final_submission_is_submitted'
    elsif final_submission_approved?
      'final_submission_is_approved'
    else
      'released_for_publication'
    end
  end

end