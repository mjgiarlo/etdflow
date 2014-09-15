require 'delegate'

class SubmissionView < SimpleDelegator

  # Our submission view should truly pose as the wrapped object,
  # since some Rails helpers will use this for naming conventions.
  def class
    __getobj__.class
  end

  def formatted_program_information
    program_name + ' ' + degree_name + ' - ' + semester + ' ' + year.to_s
  end

  def delete_link
    if beyond_collecting_format_review_files? || format_review_notes.present?
      ''
    else
      ("<span class='delete-link'><a href='" + "/author/submissions/#{id}" + "' class='text-danger' data-method='delete' data-confirm='Permanently delete this submission?' rel='nofollow' >[delete]</a></span>").html_safe
    end
  end

  def created_on
    created_at.strftime('%B %-e, %Y')
  end

  def step_one_description
    if beyond_collecting_format_review_files?
      ("Provide program information <a href='#' class='small'>[review]</a>").html_safe
    else
      ("Provide program information <a href='" + "/author/submissions/#{id}/edit" + "' class='small'>[update]</a>").html_safe
    end
  end

  def step_two_class
    if beyond_collecting_committee?
      'complete'
    else
      'current'
    end
  end

  def step_two_description
    if collecting_committee?
      ("<a href='" + "/author/submissions/#{id}/committee/new" + "'>Provide committee</a>").html_safe
    elsif collecting_format_review_files?
      ("Provide committee <a href='" + "/author/submissions/#{id}/committee/edit" + "' class='small'>[update]</a>").html_safe
    elsif beyond_collecting_format_review_files?
      ("Provide committee <a href='#' class='small'>[review]</a>").html_safe
    else
      'Provide committee'
    end
  end

  def step_two_status
    if beyond_collecting_committee?
      "<span class='glyphicon glyphicon-ok-circle'></span> completed".html_safe
    else
      ''
    end
  end

  def step_three_class
    if collecting_format_review_files?
      'current'
    elsif beyond_collecting_format_review_files?
      'complete'
    else
      ''
    end
  end

  def step_three_description
    if collecting_format_review_files?
      if format_review_notes.present?
        ("Upload Format Review files <a href='" + "/author/submissions/#{id}/format_review/edit" + "' class='small'>[update]</a>").html_safe
      else
        ("<a href='" + "/author/submissions/#{id}/format_review/edit" + "'>Upload Format Review files</a>").html_safe
      end
    elsif beyond_collecting_format_review_files?
      ("Upload Format Review files <a href='#' class='small'>[review]</a>").html_safe
    else
      'Upload Format Review files'
    end
  end

  def step_three_status
    if beyond_collecting_format_review_files?
      "<span class='glyphicon glyphicon-ok-circle'></span> completed".html_safe
    elsif collecting_format_review_files? && format_review_notes.present?
      ("<span class='fa fa-warning'></span> rejected, please see the <a href='" + "/author/submissions/#{id}/format_review/edit#format-review-notes" + "'>notes from the administrator</a>").html_safe
    else
      ''
    end
  end

  def step_four_class
    if waiting_for_format_review_response?
      'current'
    elsif beyond_waiting_for_format_review_response?
      'complete'
    else
      ''
    end
  end

  def step_four_status
    if waiting_for_format_review_response?
      'in process'
    elsif beyond_waiting_for_format_review_response?
      "<span class='glyphicon glyphicon-ok-circle'></span> approved".html_safe
    else
      ''
    end
  end

  def step_five_class
    if collecting_final_submission_files?
      'current'
    elsif beyond_collecting_final_submission_files?
      'complete'
    else
      ''
    end
  end

  def step_five_description
    if collecting_final_submission_files?
      ("<a href='" + "/author/submissions/#{id}/final_submission/edit" + "'>Upload Final Submission files</a>").html_safe
    elsif beyond_collecting_final_submission_files?
      ("Upload Final Submission files <a href='#' class='small'>[review]</a>").html_safe
    else
      'Upload Final Submission files'
    end
  end

  def step_five_status
    if beyond_collecting_final_submission_files?
      "<span class='glyphicon glyphicon-ok-circle'></span> completed".html_safe
    else
      ''
    end
  end

  def step_six_class
    if waiting_for_final_submission_response?
      'current'
    elsif beyond_waiting_for_final_submission_response?
      'complete'
    else
      ''
    end
  end

  def step_six_status
    if waiting_for_final_submission_response?
      'in process'
    elsif beyond_waiting_for_final_submission_response?
      "<span class='glyphicon glyphicon-ok-circle'></span> approved".html_safe
    else
      ''
    end
  end

end
