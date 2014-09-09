FactoryGirl.define do

  factory :submission do |s|
    author
    program
    degree
    semester "Spring"
    year Date.today.year
    title

    Degree.degree_types_json.each do |type|
      trait_name = type["parameter"].to_sym
      trait trait_name do
        association :degree, factory: :degree, degree_type: type["singular"]
      end
    end

    trait :collecting_program_information do
      status "collecting program information"
    end

    trait :collecting_committee do
      status "collecting committee"
    end

    trait :collecting_format_review_files do
      status "collecting format review files"
    end

    trait :waiting_for_format_review_response do
      status "waiting for format review response"
    end

  end
end
