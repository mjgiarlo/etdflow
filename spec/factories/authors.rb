FactoryGirl.define do

  factory :author do |p|
    sequence :access_id, 1000 do |n|
      "XYZ#{n}"
    end
    sequence :psu_email_address, 1000 do |n|
      "XYZ#{n}@psu.edu"
    end
    first_name "Joseph"
    middle_name "Quicny"
    last_name "Example"
    alternate_email_address "email@domain.com"
    phone_number "123-456-7890"
    is_alternate_email_public true
    address_1 "123 Example Ave."
    address_2 "Apt. 8H"
    city "State College"
    state "Pennsylvania"
    zip "16801"
  end

end
