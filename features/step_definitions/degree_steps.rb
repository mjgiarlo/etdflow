Given(/^some degrees exist$/) do
  @degrees = Array.new(10){ create :degree }
end

Then(/^I should see a listing of all the degrees$/) do
  pending # express the regexp above with the code you wish you had
end
