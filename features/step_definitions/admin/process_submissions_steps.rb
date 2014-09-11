Given(/^submissions exist for each type and status$/) do
  Degree.degree_types_json.each do |type|
    symbol_name = type["parameter"].to_sym
    Submission.statuses.each do |status|
      create :submission, symbol_name, status: status
    end
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

When(/^I click the title of the submitted format review$/) do
  click_link @submissions.first.title
end

Then(/^I should see a link to view the PDF file/) do
  expect(page).to have_link(@file.filename_identifier, { href: @file.filename_url })
end

When(/^the file looks good$/) do
  # Admin thinks the file is acceptable
end