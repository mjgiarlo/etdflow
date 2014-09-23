require 'delegate'

class Admin::SubmissionFormView < SimpleDelegator

  # Our submission form view should truly pose as the wrapped object,
  # since some Rails helpers will use this for naming conventions.
  def class
    __getobj__.class
  end

  def initialize(submission, session)
    super(submission)
    @session = session
  end

  def title
    if waiting_for_format_review_response?
      'Format Review Evaluation'
    elsif collecting_final_submission_files?
      'Edit Incomplete Final Submission'
    elsif waiting_for_final_submission_response?
      'Final Submission Evaluation'
    else
      'Edit Incomplete Format Review'
    end
  end

  def actions_partial_name
    if waiting_for_format_review_response?
      'format_review_evaluation_actions'
    elsif waiting_for_final_submission_response?
      'final_submission_evaluation_actions'
    else
      'standard_actions'
    end
  end

  def form_for_url
    if waiting_for_format_review_response?
      "/admin/submissions/#{id}/format_review_response"
    elsif waiting_for_final_submission_response?
      "/admin/submissions/#{id}/final_submission_response"
    else
      "#"
    end
  end

  def cancellation_path
    @session.delete(:return_to)
  end

end