FactoryGirl.define do

  factory :submission do |s|
    author
    program
    degree
    semester "Spring"
    year Date.today.year
  end

  Degree.degree_types.each do |type|
    trait_name = type.parameterize.underscore.to_sym
    trait trait_name do
      association :degree, factory: :degree, degree_type: type
    end
  end

end
