Given(/^some degrees exist$/) do
  @degrees = Array.new(10){ create :degree }
end

Then(/^I should see a listing of all the degrees$/) do
  @degrees.each do |degree|
    expect(page).to have_content degree.name
  end
end
