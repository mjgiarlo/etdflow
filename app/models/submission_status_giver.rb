class SubmissionStatusGiver
  class InvalidTransition < Exception; end
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def collecting_program_information!
    s = @submission
    new_status = 'collecting program information'
    if s.status.nil? || s.collecting_committee? || s.collecting_format_review_files?
      s.update_attribute :status, new_status
    elsif s.status == new_status
      return
    else
      raise InvalidTransition
    end 
  end

  def collecting_committee!
    s = @submission
    new_status = 'collecting committee'
    if s.collecting_program_information? || s.collecting_format_review_files?
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
    if ( s.collecting_program_information? && s.has_committee? ) || ( s.collecting_committee? && s.has_committee? ) || s.waiting_for_format_review_response?
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

end
