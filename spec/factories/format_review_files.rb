FactoryGirl.define do

  factory :format_review_file do |f|
    submission
    asset { File.open( fixture 'format_review_file_01.pdf' ) }

    trait :pdf do
      asset { File.open( fixture 'format_review_file_02.pdf' ) }
    end

    trait :docx do
      asset { File.open( fixture 'format_review_file_03.docx' ) }
    end
  end

end
