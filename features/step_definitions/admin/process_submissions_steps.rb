Given(/^some dissertation submissions exist$/) do
  create :submission, :dissertation
end

Given(/^some master thesis submissions exist$/) do
  create :submission, :master_thesis
end

Then(/^I should see all of the dissertation submissions$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see all of the master thesis submissions$/) do
  pending # express the regexp above with the code you wish you had
end
