FactoryGirl.define do

  factory :final_submission_file do |f|
    submission
    filename { File.open( fixture 'final_submission_file_01.pdf' ) }
  end

end