FactoryGirl.define do

  factory :degree do |p|
    name
    description
    degree_type "Master Thesis"
  end

  trait :dissertation do
    degree_type "Dissertation"
  end

  trait :master_thesis do
    degree_type "Master Thesis"
  end
end
