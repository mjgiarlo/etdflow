Given(/^some submissions exist for each type$/) do
  Degree.degree_types_json.each do |type|
    symbol_name = type["parameter"].to_sym
    create :submission, symbol_name
  end
end

Then(/^I should see all of the default degree type submissions$/) do
  default_degree_scope = Degree.default_degree_type
  Submission.send(default_degree_scope).each do |submission|
    expect(page).to have_content submission.program_name
    expect(page).to have_content submission.degree_name
    expect(page).to have_content submission.semester
    expect(page).to have_content submission.year
  end
end

Then(/^I should be able to navigate to all degree type submissions$/) do
  Degree.degree_types_json.each do |type|
    link_label = type['plural']
    degree_scope = type['parameter']

    click_link link_label
    Submission.send(degree_scope).each do |submission|
      expect(page).to have_content submission.program_name
      expect(page).to have_content submission.degree_name
      expect(page).to have_content submission.semester
      expect(page).to have_content submission.year
    end
  end
end
