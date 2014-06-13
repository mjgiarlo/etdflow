FactoryGirl.define do

  sequence :name, 1000 do |n|
    "name #{n}"
  end

  factory :degree do |p|
    name
    description
    degree_type "Master"
  end

end
