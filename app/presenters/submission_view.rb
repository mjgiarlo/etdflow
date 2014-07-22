require 'delegate'

class SubmissionView < SimpleDelegator

  # Our submission view should truly pose as the wrapped object,
  # since some Rails helpers will use this for naming conventions.
  def class
    __getobj__.class
  end

  def name
    program_name + ' ' + degree_name + ' - ' + semester + ' ' + year.to_s
  end

  def created_on
    created_at.strftime('%B %-e, %Y')
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
    elsif beyond_collecting_committee?
      ("Provide committee <a href='#' class='small'>[update]</a>").html_safe
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

  def committee_link
    if beyond_collecting_committee?
      ("<a href='" + "#" + "' class='small'>[update]</a>").html_safe
    else
      ''
    end
  end

  def step_three_class
    if collecting_format_review_files?
      'current'
    else
      ''
    end
  end

  def step_three_description
    if collecting_format_review_files?
      ("<a href='" + "/author/submissions/#{id}/format_review/new" + "'>Upload Format Review files</a>").html_safe
    else
      'Upload Format Review files'
    end
  end

end
