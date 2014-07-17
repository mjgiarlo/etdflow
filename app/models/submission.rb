class Submission < ActiveRecord::Base

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
      'collecting committee'
    ]
  end

  validates :status, inclusion: { in: statuses }

  def created_on
    created_at ? created_at.strftime('%B %-e, %Y') : nil
  end

  def collecting_committee?
    status == 'collecting committee' ? true : false
  end


end
