Given /^I am on (.*)$/ do |page_name|
  visit path_to(page_name)
end

When /^I go to (.*)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I should be on (.*)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :expect
    expect(current_path).to eq( path_to(page_name) )
  else
    assert_equal path_to(page_name), current_path
  end
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link link
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )check "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end
