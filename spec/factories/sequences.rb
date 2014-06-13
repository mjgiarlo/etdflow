# Sequences reused across factories
FactoryGirl.define do

  sequence :name, 1000 do |n|
    "name #{n}"
  end

  sequence :description, 1000 do |n|
    "description #{n}"
  end

end
