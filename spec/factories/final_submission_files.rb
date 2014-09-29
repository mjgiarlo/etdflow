FactoryGirl.define do

  factory :final_submission_file do |f|
    submission
    asset { File.open( fixture 'final_submission_file_01.pdf' ) }

    trait :pdf do
      asset { File.open( fixture 'final_submission_file_01.pdf' ) }
    end

    trait :docx do
      asset { File.open( fixture 'final_submission_file_02.docx' ) }
    end
  end

end
