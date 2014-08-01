FactoryGirl.define do

  factory :submission do |s|
    author
    program
    degree
    semester "Spring"
    year Date.today.year
  end

  Degree.degree_types_json.each do |type|
    trait_name = type["parameter"].to_sym
    trait trait_name do
      association :degree, factory: :degree, degree_type: type["singular"]
    end
  end

end
