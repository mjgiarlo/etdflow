Given(/^some dissertation submissions exist$/) do
  dissertation_degree = create :degree, :dissertation
  create :submission, degree: dissertation_degree
end

Given(/^some master thesis submissions exist$/) do
  master_degree = create :degree, :master_thesis
  create :submission, degree: master_degree
end

Then(/^I should see all of the dissertation submissions$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see all of the master thesis submissions$/) do
  pending # express the regexp above with the code you wish you had
end
