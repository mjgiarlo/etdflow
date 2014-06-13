class Degree <  ActiveRecord::Base

  DEGREE_TYPES = [
                  "Dissertation",
                  "Thesis",
                  "Master"
                 ].freeze

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :degree_type

  validates_inclusion_of :degree_type,  in: DEGREE_TYPES
end
