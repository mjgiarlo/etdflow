Given(/^some degrees exist$/) do
  @degrees = Array.new(10){ create :degree }
end

Then(/^I should see a listing of all the degrees$/) do
  @degrees.each do |degree|
    expect(page).to have_content degree.name
    expect(page).to have_content degree.active_status
  end
end

Then(/^I should see the degree (.*)$/) do |name|
  within('#degrees-index') do
    expect(page).to have_content name
  end
end

When(/^I choose a degree to edit$/) do
  @degree_to_edit = @degrees.first
  click_link @degree_to_edit.name
end
