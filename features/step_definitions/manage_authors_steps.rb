Given(/^some authors exist$/) do
  @authors = Array.new(10){ create :author }
end

Then(/^I should see a listing of all the authors$/) do
  @authors.each do |author|
    expect(page).to have_content author.access_id
  end
end

When(/^I choose an author to edit$/) do
  @author_to_edit = @authors.first
  click_link @author_to_edit.access_id
end

When(/^I modify the rest of author's attributes$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the author (.*)$/) do |first_name|
  within('#authors-index') do
    expect(page).to have_content first_name
  end
end

