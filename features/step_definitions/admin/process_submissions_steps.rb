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

Given(/^an incomplete format review exists$/) do
  create :submission, status: 'collecting committee'
end

Then(/^I should see the submission listed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see a button to delete all selected submissions$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should no longer see my submission$/) do
  pending # express the regexp above with the code you wish you had
end
