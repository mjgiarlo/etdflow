class Submission < ActiveRecord::Base
  class InvalidTransition < Exception; end

  belongs_to :author
  belongs_to :program
  belongs_to :degree

  has_many :committee_members

  delegate :name, to: :program, prefix: :program
  delegate :name, to: :degree, prefix: :degree
  delegate :degree_type, to: :degree

  after_initialize :set_status_to_collecting_program_information

  validates_presence_of :author_id,
                        :program_id,
                        :degree_id,
                        :semester,
                        :year

  SEMESTERS = [
                'Fall',
                'Spring',
                'Summer'
              ].freeze

  validates_inclusion_of :semester,  in: SEMESTERS

  validates :year, numericality: { only_integer: true }

  def self.years
    current_year = Date.today.year
    [
      "#{current_year}",
      "#{current_year + 1}",
      "#{current_year + 2}",
      "#{current_year + 3}"
    ]
  end

  def self.statuses
    [
      'collecting program information',
      'collecting committee',
      'collecting format review files',
      'waiting for format review response'
    ]
  end

  validates :status, inclusion: { in: statuses }

  scope :master_thesis, -> { where(degree_type: 'Master Thesis') }

  def has_committee?
    if committee_members.any?
      committee_members.count >= Committee.minimum_number_of_members
    else
      false
    end
  end

  def collecting_program_information?
    status == 'collecting program information' ? true : false
  end

  def collecting_committee?
    status == 'collecting committee' ? true : false
  end

  def collecting_format_review_files?
    status == 'collecting format review files' ? true : false
  end

  def waiting_for_format_review_response?
    status == 'waiting for format review response' ? true : false
  end

  def beyond_collecting_committee?
    collecting_format_review_files? || beyond_collecting_format_review_files?
  end

  def beyond_collecting_format_review_files?
    waiting_for_format_review_response?
  end

  def collecting_committee!
    new_status = 'collecting committee'
    if collecting_program_information?
      update_attribute :status, new_status
    elsif status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def collecting_format_review_files!
    new_status = 'collecting format review files'
    if collecting_committee?
      update_attribute :status, new_status
    elsif status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  def waiting_for_format_review_response!
    new_status = 'waiting for format review response'
    if collecting_format_review_files?
      update_attribute :status, new_status
    elsif status == new_status
      return
    else
      raise InvalidTransition
    end
  end

  private

  def set_status_to_collecting_program_information
    self.status = 'collecting program information' if self.new_record? && self.status.nil?
  end
end
