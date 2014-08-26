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
    within '.step.step-1' do
      expect(page).to have_link '[update]'
      expect(page).to have_content "completed on #{Date.today.strftime('%B %e, %Y')}"
    end
  end
end

Given(/^I have started a submission$/) do
  step "I have confirmed my contact information"
  author = Author.where(access_id: 'etdflow').first
  create :submission, author: author
end

When(/^I provide my committee$/) do
  Committee.minimum_number_of_members.times do |i|
    fill_in "committee_committee_members_attributes_#{i}_name", with: "name_#{i}"
    fill_in "committee_committee_members_attributes_#{i}_email", with: "name_#{i}@example.com"
  end
end

Then(/^My committee progress indicator should be updated$/) do
  within '#submission-1' do
    within '.step.step-2' do
      expect(page).to have_link '[update]'
      expect(page).to have_content "completed"
    end
  end
end

Then /^I should now be on "(.*?)" "(.*?)"$/ do |step, name|
  expect(page).to have_css ".step.#{step}.current"
  expect(page).to have_link name
end

When(/^I choose my Format Review files$/) do
  click_link 'Additional File'
  expect(page).to have_css '.file.required.form-control'
  first_input_id = first('input[type="file"]')[:id]
  attach_file first_input_id, fixture('format_review_file_01.pdf')
end

Then(/^The system should save my files$/) do
  expect(FormatReviewFile.count).to eq 1
end

Then(/^I should see that my Format Review is in process$/) do
  within '.step-3' do
    expect(page).to have_link '[review]'
  end
  within '.step-4' do
    expect(page).to have_content 'in process'
  end
  expect(page).to have_css ".step.step-4.current"
end

Given(/^I have started a submission and provided my committee$/) do
  step 'I have confirmed my contact information'
  step 'I go to the author submissions page'
  step 'I click the "Start a new Submission" link'
  step 'I should be on the new submission program information page'
  step 'I fill in my program information'
  step 'I click the "Save Program Information" button'
  step 'I should be on the author submissions page'
  step 'I should see my new program information'
  step 'My program information progress indicator should be updated'
  step 'I should now be on "step-2" "Provide committee"'
  step 'I click the "Provide committee" link within "#submission-1"'
  step 'I provide my committee'
  step 'I click the "Save Committee" button'
  step 'I should be on the author submissions page'
  step 'My committee progress indicator should be updated'
  step 'I should now be on "step-3" "Upload Format Review files"'
end

When(/^I enter my new committee information$/) do
  Committee.minimum_number_of_members.times do |i|
    fill_in "committee_committee_members_attributes_#{i}_name", with: "new_name"
    fill_in "committee_committee_members_attributes_#{i}_email", with: "new_name@example.com"
  end
end

Then(/^my committee should be updated$/) do
  s = Submission.first
  expect(s.committee_members.count).to eq 4
  s.committee_members.all.each do |member|
    expect(member.name).to eq 'new_name'
    expect(member.email).to eq 'new_name@example.com'
  end
end
