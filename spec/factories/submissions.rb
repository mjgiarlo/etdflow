FactoryGirl.define do

  factory :submission do |s|
    author
    program
    degree
    semester "Spring"
    year Date.today.year
  end

end
