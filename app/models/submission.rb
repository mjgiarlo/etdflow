class Submission < ActiveRecord::Base

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

end
