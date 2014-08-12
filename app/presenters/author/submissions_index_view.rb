class SubmissionsIndexView
  attr_reader :submissions

  def initialize(author)
    @author = author
    @submissions = @author.submissions
  end

  def partial_name
    if new_author?
      'confirm_contact_information_instructions'
    elsif author_has_submissions?
      'submissions'
    else
      'no_submissions'
    end
  end

  def new_author?
    @author.new_record?
  end

  def author_has_submissions?
    @author.submissions.any?
  end

end
