FactoryGirl.define do

  factory :submission do |s|
    author
    title
    program
    degree
    semester "Spring"
    year Date.today.year

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

    trait :collecting_final_submission_files do
      status "collecting final submission files"
      format_review_notes "Format review were accepted"
    end

    trait :waiting_for_final_submission_response do
      status "waiting for final submission response"
      format_review_notes "Format review notes"
      defended_at (Time.zone.now - 30.days)
    end

    trait :waiting_for_publication_release do
      status "waiting for final submission response"
      format_review_notes "Format review notes"
      final_submission_notes "Final submission notes"
      defended_at (Time.zone.now - 30.days)
    end

  end
end
