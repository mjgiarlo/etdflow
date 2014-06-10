FactoryGirl.define do

  sequence :description, 1000 do |n|
    "description #{n}"
  end

  factory :program do |p|
    description
  end

end
