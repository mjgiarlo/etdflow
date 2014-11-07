class Author::SubmissionsIndexView
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
      if !author_ldap_info_valid?
        'confirm_ldap_information'
      else
        'no_submissions'
      end
    end
  end

  def new_author?
    @author.new_record?
  end

  def author_has_submissions?
    @author.submissions.any?
  end

  def author_ldap_info_valid?
    #Must force author to edit LDAP contact information if attributes are missing or invalid.
    @author.valid?
  end

end
