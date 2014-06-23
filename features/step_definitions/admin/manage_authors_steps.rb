Given(/^some authors exist$/) do
  @authors = Array.new(10){ create :author }
end

Then(/^I should see a listing of all the authors$/) do
  @authors.each do |author|
    expect(page).to have_content author.access_id
  end
end

When(/^I choose an author to edit$/) do
  @author_to_edit = @authors.first
  click_link @author_to_edit.access_id
end

When(/^I modify the rest of author's attributes$/) do
  step 'I fill in "Last name" with "NEW-LAST-NAME"'
  step 'I fill in "Middle name" with "NEW-MIDDLE-NAME"'
  step 'I fill in "Alternate email address" with "NEW-ALTERNATE-EMAIL-ADDRESS@example.com"'
  step 'I fill in "PSU email address" with "NEW-PSU_EMAIL-ADDRESS@psu.edu"'
  step 'I fill in "Phone number" with "123-456-7890"'
  step 'I check "Is alternate email public"'
  step 'I fill in "Address 1" with "NEW-ADDRESS-1"'
  step 'I fill in "Address 2" with "NEW-ADDRESS-2"'
  step 'I fill in "City" with "NEW-CITY"'
  step 'I select "New Jersey" from "State"'
  step 'I fill in "Zip" with "12345"'
end

Then(/^I should see the author (.*)$/) do |first_name|
  within('#authors-index') do
    expect(page).to have_content first_name
  end
end

