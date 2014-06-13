FactoryGirl.define do

  factory :degree do |p|

    sequence :name, 1000 do |n|
      "degree name #{n}"
    end

    description
    degree_type "Master"
  end

end
