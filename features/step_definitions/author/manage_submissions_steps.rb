Given(/^I have not yet entered my author information$/) do
  expect(Author.count).to be_zero
end

Then(/^I should be prompted to confirm my contact information$/) do
  expect(page).to have_link 'Confirm my contact information'
  expect(page).to_not have_content 'My Submissions'
end

When(/^I fill in my author information$/) do
  # Due to http_basic_auth the author's access_id has to be set as the
  # http_basic_auth user. This step will break when we eventually
  # disband http_basic_auth.
  step 'I fill in "Access id" with "etdflow"'
  step 'I fill in "First name" with "NEW-FIRST-NAME"'
  step 'I fill in "Middle name" with "NEW-MIDDLE-NAME"'
  step 'I fill in "Last name" with "NEW-LAST-NAME"'
  step 'I fill in "Alternate email address" with "NEW-ALTERNATE-EMAIL-ADDRESS@example.com"'
  step 'I fill in "PSU email address" with "NEW-PSU_EMAIL-ADDRESS@psu.edu"'
  step 'I fill in "Phone number" with "123-456-7890"'
  step 'I check "Display your alternate email address on your eTD document summary page?"' if Author.ask_to_display_email?
  step 'I fill in "Address 1" with "NEW-ADDRESS-1"'
  step 'I fill in "Address 2" with "NEW-ADDRESS-2"'
  step 'I fill in "City" with "NEW-CITY"'
  step "I select 'New Jersey' from 'State'"
  step 'I fill in "Zip" with "12345"'
end

Then(/^I should see that I don't have any submissions yet$/) do
  expect(page).to have_content "You don't have any submissions yet"
end

Then(/^I should see my new contact information$/) do
  within '#contact-information' do
    expect(page).to have_content "NEW-FIRST-NAME NEW-MIDDLE-NAME NEW-LAST-NAME"
    expect(page).to have_content "123-456-7890"
  end
end

Given(/^I have confirmed my contact information$/) do
  # Due to http_basic_auth the author's access_id has to be set as the
  # http_basic_auth user.
  create :author, access_id: 'etdflow'
end

When(/^I fill in my program information$/) do
  step "I select 'Spring' from 'Semester Intending to Graduate'"
  step "I select \'#{Date.today.year}\' from 'Graduation Year'"
  step "I select \'#{Program.first.name}\' from 'Program'"
  step "I select \'#{Degree.first.name}\' from 'Degree'"
end

Then(/^I should see my new program information$/) do
  expect(page).to have_content "#{Program.first.name} #{Degree.first.name} - Spring #{Date.today.year}"
end

Then(/^My program information progress indicator should be updated$/) do
  expect(page).to_not have_css ".preview"
  within '#submission-1' do
    expect(page).to have_link '[update]'
    expect(page).to have_content "completed on #{Date.today.strftime('%B %e, %Y')}"
  end
end

Given(/^My contact information already exists in etdlfow$/) do
  step "I have confirmed my contact information"
end

Given(/^I have started a submission$/) do
  step "I have confirmed my contact information"
  author = Author.where(access_id: 'etdflow').first
  create :submission, author: author
end
