Given(/^some authors exist$/) do
  @authors = Array.new(10){ create :author }
end

Then(/^I should see a listing of all the authors$/) do
  pending # express the regexp above with the code you wish you had
end
