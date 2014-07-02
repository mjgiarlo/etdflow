Given(/^I have not yet entered my author information$/) do
  expect(Author.count).to be_zero
end

Then(/^I should be prompted to confirm my contact information$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I fill in my author information$/) do
  step 'I fill in "Last name" with "NEW-LAST-NAME"'
  step 'I fill in "Middle name" with "NEW-MIDDLE-NAME"'
  step 'I fill in "Alternate email address" with "NEW-ALTERNATE-EMAIL-ADDRESS@example.com"'
  step 'I fill in "PSU email address" with "NEW-PSU_EMAIL-ADDRESS@psu.edu"'
  step 'I fill in "Phone number" with "123-456-7890"'
  step 'I check "Display your alternate email address on your eTD document summary page?"' if Paper.ask_to_display_email?
  step 'I fill in "Address 1" with "NEW-ADDRESS-1"'
  step 'I fill in "Address 2" with "NEW-ADDRESS-2"'
  step 'I fill in "City" with "NEW-CITY"'
  step 'I select "New Jersey" from "State"'
  step 'I fill in "Zip" with "12345"'
end

Then(/^I should see that I don't have any submissions yet$/) do
  pending # express the regexp above with the code you wish you had
end