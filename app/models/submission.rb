class Submission < ActiveRecord::Base
  class InvalidTransition < Exception; end

  belongs_to :author
  belongs_to :program
  belongs_to :degree

  has_many :committee_members

  delegate :name, to: :program, prefix: :program
  delegate :name, to: :degree, prefix: :degree

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
      nil,
      'collecting committee',
      'collecting format review files'
    ]
  end

  validates :status, inclusion: { in: statuses }

  def created_on
    created_at ? created_at.strftime('%B %-e, %Y') : nil
  end

  def collecting_committee?
    status == 'collecting committee' ? true : false
  end

  def has_committee?
    if committee_members.any?
      committee_members.count >= Committee.minimum_number_of_members
    else
      false
    end
  end

  def collecting_committee!
    if status == nil
      status = 'collecting committee'
      update_attribute :status, status
    elsif status == 'collecting committee'
      return
    else
      raise InvalidTransition
    end
  end

end
