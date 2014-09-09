FactoryGirl.define do

  factory :format_review_file do |f|
    submission
    filename { File.open( fixture 'format_review_file_01.pdf' ) }
  end

end