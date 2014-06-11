Given(/^I am a partner admin$/) do
  # Take our word for it.
end

Given(/^some programs exist$/) do
  @programs = Array.new(10){ create :program }
end

Then(/^I should see a listing of all the programs$/) do
  @programs.each do |program|
    expect(page).to have_content program.description
  end
end

Then(/^I should see the new program$/) do
  within('#programs-index') do
    expect(page).to have_content 'Acoustics'
  end
end
