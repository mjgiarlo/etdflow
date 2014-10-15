Given(/^submissions exist for each type and status$/) do
  Degree.degree_types_json.each do |type|
    symbol_name = type["parameter"].to_sym
    create :submission, symbol_name, :collecting_program_information
    create :submission, symbol_name, :collecting_committee
    create :submission, symbol_name, :collecting_format_review_files
    create :submission, symbol_name, :waiting_for_format_review_response
  end
end

Then(/^I should see the title for the default degree type$/) do
  default_degree_type = Degree.default_degree_type
  label = default_degree_type.titleize

  within 'h1' do
    expect(page).to have_content label
  end
end

Then(/^I should be able to navigate to all submissions by degree type/) do
  Degree.degree_types_json.each do |type|
    label = type['plural']

    click_link label
    within 'h1' do
      expect(page).to have_content label
    end
  end
end

Given(/^two incomplete format review exists$/) do
  @submissions = Array.new(2) { create :submission, status: 'collecting committee' }
end

Then(/^I should see the submission(?:s)? listed$/) do
  @submissions.each do |submission|
    expect(page).to have_content submission.title
    expect(page).to have_content submission.author_last_name
    expect(page).to have_content submission.author_first_name
  end
end

Then(/^I should see a button to delete selected$/) do
  expect(page).to have_button 'Delete selected'
end

Then(/^I should no longer see the submission(?:s)?$/) do
  @submissions.each do |submission|
    within '.admin-submissions-index' do
      expect(page).to_not have_content submission.title
      expect(page).to_not have_content submission.author_last_name
      expect(page).to_not have_content submission.author_first_name
    end
  end
end

Given(/^a submitted format review exists$/) do
  def make_submission
    create :submission, :waiting_for_format_review_response
  end
  @submissions = [make_submission]
  @committee = create_committee @submissions.first
  @file = create :format_review_file, submission: @submissions.first
end

Given(/^a submitted final submission exists$/) do
  def make_submission
    create :submission, :waiting_for_final_submission_response
  end
  @submissions = [make_submission]
  @committee = create_committee @submissions.first
  @file = create :final_submission_file, submission: @submissions.first
end

When(/^I click the title of the submission$/) do
  click_link @submissions.first.title
end

Then(/^I should see the format review fields$/) do
  s = Submission.first
  expect(page).to have_field "Program*"
  expect(page).to have_field "Degree*"
  expect(page).to have_field "Semester Intending to Graduate*"
  expect(page).to have_field "Graduation Year*"
  s.committee_members.each do |member|
    expect(page).to have_content "#{member.role}*"
  end
  expect(page).to have_field "Format Review Notes to Student*"
end

Then(/^I should not see the format review fields$/) do
  s = Submission.first
  expect(page).to_not have_field "Program*"
  expect(page).to_not have_field "Degree*"
  expect(page).to_not have_field "Semester Intending to Graduate*"
  expect(page).to_not have_field "Graduation Year*"
  s.committee_members.each do |member|
    expect(page).to_not have_content "#{member.role}*"
  end
  expect(page).to_not have_field "Format Review Notes to Student*"
end

Then(/^I should see valid content in the final submissions fields$/) do
  expect(find_field('submission_defended_at_1i').value).to eq '2014'
  expect(find_field('submission_defended_at_2i').value).to eq '9'
  expect(find_field('submission_defended_at_3i').value).to eq '1'
  expect(find_field('submission[abstract]').value).to eq 'my abstract'
  expect(find_field('submission[keywords]').value).to eq 'key, word'
  expect(page.has_checked_field?('submission_access_level_open_access')).to be_true
end

When(/^I click the Format Review Information heading$/) do
  heading = first("div[data-target='#format-review-files']")
  heading.click
end

Then(/^I should see that the Format Review Notes to Stundent field is readonly$/) do
  expect(page).to have_field "Format Review Notes to Student*"
  expect(page).to have_css "#submission_format_review_notes[readonly]"
end

Then(/^I should see a button to edit the Format Review Information$/) do
  expect(page).to have_link "Edit Format Review Information"
end

Then(/^I should see the edit button update$/) do
  expect(page).to_not have_link "Edit Format Review Information"
  expect(page).to have_link "Lock Format Review Information"
end

Then(/^I should now be able to edit the Format Review Notes to Student field$/) do
  expect(page).to_not have_css "#submission_format_review_notes[readonly]"
end

And(/^I should see a link to view the PDF file/) do
  expect(page).to have_link(@file.asset_identifier, { href: @file.asset_url })
end

When(/^the file looks good$/) do
  # Admin thinks the file is acceptable
end

Then(/^the file looks bad$/) do
  # Admin thinks the file is unacceptable
end

Given(/^one approved final submission exists for each access level$/) do
  @submissions = []
  @submissions << (create :submission, :waiting_for_publication_release, access_level: 'open_access')
  @submissions << (create :submission, :waiting_for_publication_release, access_level: 'restricted_to_institution')
  @submissions << (create :submission, :waiting_for_publication_release, access_level: 'restricted')
end

Then(/^I should see a button to release for publication$/) do
  expect(page).to have_button 'Release selected for publication'
end

Then(/^I should see that there are zero approved final submissions$/) do
  within '#final-submission-approved.no-submissions .badge' do
    expect(page).to have_content '0'
  end
end

Then(/^all the Released eTDs should be archived in Fedora$/) do

 expect(Paper.count).to eq @submissions.count
 # Each Paper should have the same number of generic_files
 # as the associated Submission has final_submission_files
 Paper.all.each do |paper|
   submission = Submission.where(fedora_id: paper.id).first
   expect(paper.generic_files.count).to eq submission.final_submission_files.count
 end
end
