Given(/^some authors exist$/) do
  @authors = Array.new(10){ create :author }
end

Then(/^I should see a listing of all the authors$/) do
  @authors.each do |author|
    expect(page).to have_content author.access_id
  end
end
