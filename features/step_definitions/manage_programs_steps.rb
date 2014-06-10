Given(/^I am a partner admin$/) do
  # Take our word for it.
end

Given(/^some programs exist$/) do
  @programs = Array.new(10){ create :program }
end

Then(/^I should see a listing of all the programs$/) do
  pending # express the regexp above with the code you wish you had
end
