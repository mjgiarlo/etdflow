# Generalized step definitions for navigation

Given /^I am on (.*)$/ do |page_name|
  visit path_to(page_name)
end

When /^I go to (.*)$/ do |page_name|
  visit path_to(page_name)
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link link
end

Then /^I should be on (.*)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :expect
    expect(current_path).to eq( path_to(page_name) )
  else
    assert_equal path_to(page_name), current_path
  end
end
