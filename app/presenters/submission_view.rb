class SubmissionView
  include Rails.application.routes.url_helpers

  attr_reader :submission

  def initialize(submission=nil)
    @submission = submission
  end

  def id
    @submission ? "submission-#{@submission.id}" : ''
  end

  def name
    @submission.program_name + ' ' + @submission.degree_name + ' - ' + @submission.semester + ' ' + @submission.year.to_s
  end

  def submission_status
    @submission ? @submission.status : nil
  end

  def submission_with_committee?
    @submission && @submission.has_committee?
  end

  def step_one_class
    @submission ? 'complete' : ''
  end

  def step_one_status
    @submission ? "<span class='glyphicon glyphicon-ok-circle'></span> completed on #{@submission.created_on}".html_safe : ''
  end

  def program_information_link
    @submission ? "<a href='" + edit_author_submission_path(@submission) + "' class='small'>[update]</a>".html_safe : ''
  end

  def step_two_class
    if submission_status == 'collecting committee'
      'current'
    elsif submission_with_committee?
      'complete'
    else
        ''
    end
  end

  def step_two_status
    submission_with_committee? ? "<span class='glyphicon glyphicon-ok-circle'></span> completed".html_safe : ''
  end

  def committee_link
    submission_with_committee? ? "<a href='" + "#" + "' class='small'>[update]</a>".html_safe : ''
  end

end
