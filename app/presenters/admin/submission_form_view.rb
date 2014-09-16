require 'delegate'

class Admin::SubmissionFormView < SimpleDelegator

  # Our submission form view should truly pose as the wrapped object,
  # since some Rails helpers will use this for naming conventions.
  def class
    __getobj__.class
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

end