FactoryGirl.define do

  factory :submission do |s|
    author
    program
    degree
    semester "Spring"
    year Date.today.year
  end

  trait :dissertation do
    association :degree, factory: :degree, degree_type: "Dissertation"
  end

  trait :master_thesis do
    association :degree, factory: :degree, degree_type: "Master Thesis"
  end
end
