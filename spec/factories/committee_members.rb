FactoryGirl.define do

  factory :committee_member do |cm|
    submission
    role "Committee Member"
    name "Professor Buck Murphy"
    email "buck@hotmail.com"
    is_advisor false
  end

  trait :advisor do
    role "Advisor"
    is_advisor true
  end

end
