Given(/^I have confirmed my contact information$/) do
  # Due to http_basic_auth the author's access_id has to be set as the
  # http_basic_auth user.
  create :author, access_id: 'etdflow'
end

When(/^I fill in my program information$/) do
  fill_in 'Title', with: 'Test Submission Title'
  step "I select 'Spring' from 'Semester Intending to Graduate'"
  step "I select \'#{Date.today.year}\' from 'Graduation Year'"
  step "I select \'#{Program.first.name}\' from 'Program'"
  step "I select \'#{Degree.first.name}\' from 'Degree'"
end

Then(/^I should see my new program information$/) do
  submission = Submission.first
  expect(page).to have_content submission.title
  expect(page).to have_content "#{submission.program_name} #{submission.degree_name} - Spring #{Date.today.year}"
end

Then(/^My program information progress indicator should be updated$/) do
  expect(page).to_not have_css '.preview'
  within '#submission-1' do
    within '.step.step-1' do
      expect(page).to have_link '[update]'
      expect(page).to have_content "completed on #{Time.zone.now.strftime('%B %-e, %Y')}"
    end
  end
end

Given(/^I have started a submission$/) do
  step "I have confirmed my contact information"
  author = Author.where(access_id: 'etdflow').first
  s = create :submission, author: author
  s.update_attribute :status, "collecting committee"
end

When(/^I provide my committee$/) do
  Committee.minimum_number_of_members.times do |i|
    fill_in "committee_committee_members_attributes_#{i}_name", with: "name_#{i}"
    fill_in "committee_committee_members_attributes_#{i}_email", with: "name_#{i}@example.com"
  end
end

Then(/^My committee progress indicator should be updated$/) do
  submission = Submission.first
  within '#submission-1' do
    within '.step.step-2' do
      expect(page).to have_link '[update]'
      expect(page).to have_content "completed on #{submission.committee_provided_at.strftime('%B %-e, %Y')}"
    end
  end
end

Then /^I should now be on "(.*?)" "(.*?)"$/ do |step, name|
  expect(page).to have_css ".step.#{step}.current"
  expect(page).to have_link name
end

When(/^I choose my Format Review files$/) do
  expect(page).to have_css '#format-review-file-fields .nested-fields:first-child input[type="file"]'
  first_input_id = first('#format-review-file-fields .nested-fields:first-child input[type="file"]')[:id]
  attach_file first_input_id, fixture('format_review_file_01.pdf')
  click_link 'Additional File'
  expect(page).to have_css '#format-review-file-fields .nested-fields:first-child + .nested-fields input[type="file"]'
  second_input_id = first('#format-review-file-fields .nested-fields:first-child + .nested-fields input[type="file"]')[:id]
  attach_file second_input_id, fixture('format_review_file_02.pdf')
end

Then(/^The system should save my Format Review files$/) do
  expect(FormatReviewFile.count).to eq 2
end

Then(/^I should see that my Format Review is being reviewed$/) do
  submission = Submission.first
  within '.step-3' do
    expect(page).to have_link '[review]'
    expect(page).to have_content "completed on #{submission.format_review_files_uploaded_at.strftime('%B %-e, %Y')}"
  end
  within '.step-4' do
    expect(page).to have_content 'under review by an administrator'
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

When(/^My Format Review is approved$/) do
  s = Submission.first
  s.format_review_notes = 'Great job!'
  s.save!
  status_giver = SubmissionStatusGiver.new(s)
  status_giver.collecting_final_submission_files!
  s.update_attribute :format_review_approved_at, Time.zone.now
  expect(s.beyond_waiting_for_format_review_response?).to be_true
  visit author_submissions_path
end

Then(/^My Format Review approval progress indicator should be updated$/) do
  submission = Submission.first
  within '#submission-1' do
    within '.step.step-4' do
      expect(page).to have_content "approved on #{submission.format_review_approved_at.strftime('%B %-e, %Y')}"
    end
  end
end

When(/^I fill in the Final Submission fields$/) do
  select Time.zone.now.year, from: 'submission[defended_at(1i)]'
  select Time.zone.now.strftime('%B'), from: 'submission[defended_at(2i)]'
  select Time.zone.now.day, from: 'submission[defended_at(3i)]'
  fill_in 'Abstract', with: 'Abstract words'
  fill_in 'Keywords', with: 'word, tag, value'
  choose 'Restricted'
  check 'I agree'
end

When(/^I upload my Final Submission files$/) do
  expect(page).to have_css '#final-submission-file-fields .nested-fields:first-child input[type="file"]'
  first_input_id = first('#final-submission-file-fields .nested-fields:first-child input[type="file"]')[:id]
  attach_file first_input_id, fixture('final_submission_file_01.pdf')
end

Then(/^The system should save my Final Submission files$/) do
  expect(FinalSubmissionFile.count).to eq 1
end

Then(/^I should see that my Final Submission is being reviewed$/) do
  within '.step-5' do
    expect(page).to have_link '[review]'
  end
  within '.step-6' do
    expect(page).to have_content 'under review by an administrator'
  end
  expect(page).to have_css ".step.step-6.current"
end

Given(/^I have submitted my format review for response/) do
  steps %Q{
    Given I have started a submission and provided my committee
    When I click the "Upload Format Review files" link within "#submission-1"
    And I choose my Format Review files
    And I click the "Submit files for review" button
    Then The system should save my Format Review files
    And I should be on the author submissions page
    And I should see that my Format Review is being reviewed
  }
end


Given(/^My Format Review is rejected/) do
  s = Submission.first
  s.format_review_notes = 'Please revise!'
  s.save!
  status_giver = SubmissionStatusGiver.new(s)
  status_giver.collecting_format_review_files!
  s.update_attribute :format_review_rejected_at, Time.zone.now
  expect(s.collecting_format_review_files?).to be_true
end

Then(/^I should see that my format review was rejected$/) do
  submission = Submission.first
  within '#submission-1' do
    expect(page).to_not have_link '[delete]'

    within '.step-3' do
      expect(page).to have_link '[update]'
      expect(page).to have_content "rejected on #{submission.format_review_rejected_at.strftime('%B %-e, %Y')}"
    end
  end
end

Then(/^I should see the reason for my format review's rejection$/) do
  s = Submission.first
  within "#format-review-notes" do
    expect(page).to have_content s.format_review_notes
  end
end

When(/^I update my Format Review files$/) do
  within "#format-review-file-1" do
    click_link "[delete]"
  end
  within "#format-review-file-2" do
    click_link "[delete]"
  end
  click_link 'Additional File'
  expect(page).to have_css '#format-review-file-fields .nested-fields:last-child input[type="file"]'
  new_input_id = first('#format-review-file-fields .nested-fields:last-child input[type="file"]')[:id]
  attach_file new_input_id, fixture('format_review_file_03.docx')
end

Then(/^The system should save my updated Format Review file$/) do
  expect(FormatReviewFile.count).to eq 1
end

Then(/^I should see all of my format review files$/) do
  submission = Submission.first
  submission.format_review_files.each do |file|
    within "#format-review-file-#{file.id}" do
      expect(page).to have_link file.filename_identifier
    end
  end
end

Then(/^I should see Format Review Notes from the administrator$/) do
  within '#format-review-notes' do
    expect(page).to have_content 'Great job!'
  end
end

Then(/^I should see all of my program information$/) do
  s = Submission.first
  within 'body.submissions.program_information' do
    expect(page).to have_content s.title
    expect(page).to have_content s.program_name
    expect(page).to have_content s.degree_name
    expect(page).to have_content s.semester
    expect(page).to have_content s.year
  end
end

Then(/^I should see all of my committee information$/) do
  s = Submission.first
  within 'body.submissions.committee' do
    s.committee_members.each do |member|
      expect(page).to have_content member.role
      expect(page).to have_content member.name
      expect(page).to have_content member.email
    end
  end
end

Given(/^I have submitted my final submission for response$/) do
  steps %Q{
    Given I have submitted my format review for response
    When My Format Review is approved
    Then My Format Review approval progress indicator should be updated
    And I should now be on "step-5" "Upload Final Submission files"
    When I click the "Upload Final Submission files" link within "#submission-1"
    And I fill in the Final Submission fields
    And I upload my Final Submission files
    And I click the "Submit final files for review" button
    Then The system should save my Final Submission files
    And I should be on the author submissions page
    And I should see that my Final Submission is being reviewed
  }
end

Given(/^My Final Submission is approved$/) do
  s = Submission.first
  s.final_submission_notes = 'Your final submission looks great!'
  s.save!
  status_giver = SubmissionStatusGiver.new(s)
  status_giver.waiting_for_publication_release!
  s.update_attribute :final_submission_approved_at, Time.zone.now
  expect(s.beyond_waiting_for_final_submission_response?).to be_true
  visit author_submissions_path
end

Then(/^My Final Submission approval progress indicator should be updated$/) do
  submission = Submission.first
  within '#submission-1' do
    within '.step.step-6' do
      expect(page).to have_content "approved on #{submission.final_submission_approved_at.strftime('%B %-e, %Y')}"
    end
  end
end

Then(/^I should see all of my final submission files$/) do
  submission = Submission.first
  submission.final_submission_files.each do |file|
    within "#final-submission-file-#{file.id}" do
      expect(page).to have_link file.filename_identifier
    end
  end
end

Then(/^I should see all of my final submission information$/) do
  s = Submission.first
  expect(page).to have_content s.defended_at.strftime('%B %-e, %Y')
  expect(page).to have_content s.abstract
  expect(page).to have_content s.keywords
  expect(page).to have_content s.access_level
end

Then(/^I should see Final Submission Notes from the administrator$/) do
  within '#final-submission-notes' do
    expect(page).to have_content 'Your final submission looks great!'
  end
end

Given(/^My Final Submission is rejected$/) do
  s = Submission.first
  s.final_submission_notes = 'Please update!'
  s.save!
  status_giver = SubmissionStatusGiver.new(s)
  status_giver.collecting_final_submission_files!
  s.update_attribute :final_submission_rejected_at, Time.zone.now
  expect(s.collecting_final_submission_files?).to be_true
end

Then(/^I should see that my final submission was rejected$/) do
  submission = Submission.first
  within '#submission-1 .step-5' do
    expect(page).to have_link '[update]'
    expect(page).to have_content "rejected on #{submission.final_submission_rejected_at.strftime('%B %-e, %Y')}"
  end
end

Then(/^I should see the reason for my final submission's rejection$/) do
  s = Submission.first
  within "#final-submission-notes" do
    expect(page).to have_content s.final_submission_notes
  end
end

When(/^I update my Final Submission files$/) do
  within "#final-submission-file-1" do
    click_link "[delete]"
  end
  click_link 'Additional File'
  expect(page).to have_css '#final-submission-file-fields .nested-fields:last-child input[type="file"]'
  new_input_id = first('#final-submission-file-fields .nested-fields:last-child input[type="file"]')[:id]
  attach_file new_input_id, fixture('final_submission_file_02.docx')
end

Then(/^The system should save my updated Final Submission file$/) do
  expect(FinalSubmissionFile.count).to eq 1
  expect(FinalSubmissionFile.first.filename_identifier).to eq 'final_submission_file_02.docx'
end

Then(/^I should see that my submission's publication release is pending$/) do
  submission = Submission.first
  within '.step-7' do
    expect(page).to have_content "#{submission.access_level} publication is pending"
  end
  expect(page).to have_css ".step.step-7.current"
end