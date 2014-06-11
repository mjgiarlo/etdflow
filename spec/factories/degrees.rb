FactoryGirl.define do

  sequence :name, 1000 do |n|
    "name #{n}"
  end

  sequence :degree_type, 1000 do |n|
    "degree_type #{n}"
  end

  factory :degree do |p|
    name
    description
    degree_type
  end

end
