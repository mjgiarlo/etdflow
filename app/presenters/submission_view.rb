class SubmissionView

  def initialize(submission=nil)
    @submission = submission
  end

  def id
    @submission ? "submission-#{@submission.id}" : ''
  end

  def name
    @submission.program_name + ' ' + @submission.degree_name + ' - ' + @submission.semester + ' ' + @submission.year.to_s
  end

  def step_one_class
    @submission ? 'complete' : ''
  end

  def step_one_status
    @submission ? "<span class='glyphicon glyphicon-ok-circle'></span> completed on #{@submission.created_on}".html_safe : ''
  end

  def program_information_link
    @submission ? "<a href='#' class='small'>[update]</a>".html_safe : ''
  end

  def step_two_class
    @submission ? 'current' : ''
  end

end