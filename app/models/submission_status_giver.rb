class SubmissionStatusGiver
  class AccessForbidden < StandardError; end
  class InvalidTransition < StandardError; end
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def can_update_program_information?
    s = @submission
    if s.collecting_committee? || s.collecting_format_review_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_provide_new_committee?
    s = @submission
    if s.collecting_committee?
      return
    else
      raise AccessForbidden
    end
  end

  def can_update_committee?
    s = @submission
    if s.collecting_format_review_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_upload_format_review_files?
    s = @submission
    if s.collecting_format_review_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_review_program_information?
    s = @submission
    if s.beyond_collecting_format_review_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_review_committee?
    s = @submission
    if s.beyond_collecting_format_review_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_review_format_review_files?
    s = @submission
    if s.beyond_collecting_format_review_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_upload_final_submission_files?
    s = @submission
    if s.collecting_final_submission_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_review_final_submission_files?
    s = @submission
    if s.beyond_collecting_final_submission_files?
      return
    else
      raise AccessForbidden
    end
  end

  def can_release_for_publication?
    s = @submission
    if s.waiting_for_publication_release?
      return
    else
      raise AccessForbidden
    end
  end

  def collecting_committee!
    s = @submission
    new_status = 'collecting committee'
    if s.collecting_program_information?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def collecting_format_review_files!
    s = @submission
    new_status = 'collecting format review files'
    if s.collecting_committee? || s.waiting_for_format_review_response?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def waiting_for_format_review_response!
    s = @submission
    new_status = 'waiting for format review response'
    if s.collecting_format_review_files?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def collecting_final_submission_files!
    s = @submission
    new_status = 'collecting final submission files'
    if s.waiting_for_format_review_response? || s.waiting_for_final_submission_response?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def waiting_for_final_submission_response!
    s = @submission
    new_status = 'waiting for final submission response'
    if s.collecting_final_submission_files?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def waiting_for_publication_release!
    s = @submission
    new_status = 'waiting for publication release'
    if s.waiting_for_final_submission_response?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def released_for_publication!
    s = @submission
    new_status = 'released for publication'
    if s.waiting_for_publication_release?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end
  end

end
