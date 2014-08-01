class Degree <  ActiveRecord::Base

  has_many :submissions

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :degree_type

  def self.degree_types_json
    types = '['
    Etdflow::Application.config.degree_types.each do |type|
      types += '{"singular": "'
      types += type[:singular]
      types += '", "plural": "'
      types += type[:plural]
      types += '", "parameter": "'
      types += type[:plural].parameterize.underscore
      types += '"}'
      types += ',' unless type == Etdflow::Application.config.degree_types.last
    end
    types += ']'
    types_json = JSON.parse(types)
  end

  def self.degree_types
    types = []
    Degree.degree_types_json.each do |type|
      types << type["singular"]
    end
    types
  end

  validates_inclusion_of :degree_type,  in: Degree.degree_types

  validates_uniqueness_of :name

  after_initialize :set_is_active_to_true

  def active_status
    is_active ? 'Yes' : 'No'
  end

  private

  def set_is_active_to_true
    self.is_active = true if self.new_record? && self.is_active.nil?
  end

end
