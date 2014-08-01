Given(/^some dissertation submissions exist$/) do
  create :submission, :dissertations
end

Given(/^some master thesis submissions exist$/) do
  create :submission, :master_theses
end

Then(/^I should see all of the dissertation submissions$/) do
  Submission.dissertations.each do |dissertation|
    expect(page).to have_content dissertation.program_name
    expect(page).to have_content dissertation.degree_name
    expect(page).to have_content dissertation.semester
    expect(page).to have_content dissertation.year
  end
end

Then(/^I should see all of the master thesis submissions$/) do
  Submission.master_theses.each do |thesis|
    expect(page).to have_content thesis.program_name
    expect(page).to have_content thesis.degree_name
    expect(page).to have_content thesis.semester
    expect(page).to have_content thesis.year
  end
end
