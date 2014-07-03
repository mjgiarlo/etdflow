class SubmissionsIndexView

  def initialize(author)
    @author = author
  end

  def new_author?
    @author.new_record?
  end

  def partial_name
    if new_author?
      'confirm_contact_information_instructions'
    else
      'submissions'
    end
  end

end
