class Degree <  ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :degree_type

end
