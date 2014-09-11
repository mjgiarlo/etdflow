FactoryGirl.define do

  factory :degree do |p|
    name
    description
    degree_type Degree.default_degree_type.titleize.singularize
  end

end
