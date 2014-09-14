class Submission < ActiveRecord::Base

  belongs_to :author
  belongs_to :program
  belongs_to :degree

  has_many :committee_members, dependent: :destroy
  has_many :format_review_files, dependent: :destroy
  has_many :final_submission_files, dependent: :destroy

  delegate :name, to: :program, prefix: :program
  delegate :name, to: :degree, prefix: :degree
  delegate :degree_type, to: :degree
  delegate :first_name, to: :author, prefix: :author
  delegate :last_name, to: :author, prefix: :author

  after_initialize :set_status_to_collecting_program_information

  validates_presence_of :author_id,
                        :title,
                        :program_id,
                        :degree_id,
                        :semester,
                        :year

  validates :format_review_notes,
      presence: true,
      if: Proc.new { |s| s.beyond_collecting_format_review_files? }

  accepts_nested_attributes_for :committee_members
  accepts_nested_attributes_for :format_review_files, allow_destroy: true
  accepts_nested_attributes_for :final_submission_files, allow_destroy: true

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
      'waiting for format review response',
      'collecting final submission files',
      'waiting for final submission response',
      'waiting for publication release',
      'released for publication'
    ]
  end

  validates :status, inclusion: { in: statuses }

  def parameterized_degree_type
    matching_degree_type = Degree.degree_types_json.find { |type| type['singular'] == degree_type }
    matching_degree_type['parameter']
  end

  Degree.degree_types_json.each do |type|
    symbol_name = type["parameter"].to_sym
    scope symbol_name, -> {
      joins(:degree).where('degrees.degree_type' => type["singular"])
    }
  end

  scope :format_review_is_incomplete, -> {
      where('status = ? OR status = ? OR status = ?', 'collecting program information', 'collecting committee', 'collecting format review files')
  }
  scope :format_review_is_submitted, -> { where(status: 'waiting for format review response') }
  scope :final_submission_is_incomplete, -> { where(status: 'collecting final submission files') }

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

  def collecting_final_submission_files?
    status == 'collecting final submission files' ? true : false
  end

  def waiting_for_final_submission_response?
    status == 'waiting for final submission response' ? true : false
  end

  def waiting_for_publication_release?
    status == 'waiting for publication release' ? true : false
  end

  def released_for_publication?
    status == 'released for publication' ? true : false
  end

  def beyond_collecting_committee?
    collecting_format_review_files? || beyond_collecting_format_review_files?
  end

  def beyond_collecting_format_review_files?
    waiting_for_format_review_response? || beyond_waiting_for_format_review_response?
  end

  def beyond_waiting_for_format_review_response?
    collecting_final_submission_files? || beyond_collecting_final_submission_files?
  end

  def beyond_collecting_final_submission_files?
    waiting_for_final_submission_response? || beyond_waiting_for_final_submission_response?
  end

  def beyond_waiting_for_final_submission_response?
    waiting_for_publication_release? || released_for_publication?
  end

  private

  def set_status_to_collecting_program_information
    self.status = 'collecting program information' if self.new_record? && self.status.nil?
  end
end
