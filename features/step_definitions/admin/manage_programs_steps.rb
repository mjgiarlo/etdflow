Given(/^I am a partner admin$/) do
  # Take our word for it.
end

Given(/^some programs exist$/) do
  @programs = Array.new(10){ create :program }
end

Then(/^I should see a listing of all the programs$/) do
  @programs.each do |program|
    expect(page).to have_content program.name
    expect(page).to have_content program.active_status
  end
end

Then(/^I should see the program (.*)$/) do |name|
  within('#programs-index') do
    expect(page).to have_content name
  end
end

When(/^I choose a program to edit$/) do
  @program_to_edit = @programs.first
  click_link @program_to_edit.name
end