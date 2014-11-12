# Generalized step definitions for navigation
require 'uri'

Given /^I am on (.*)$/ do |page_name|
  basic_auth_and_visit path_to(page_name)
end

When /^I go to (.*)$/ do |page_name|
  basic_auth_and_visit path_to(page_name)
end

When /^I click the "(.*?)" link(?: within "([^"]*)")?$/ do |link, selector|
  with_scope selector do
    click_link link
  end
end

When(/^I click the "(.*?)" button$/) do |button|
  click_button button
end

Then /^I should be on (.*)$/ do |page_name|
  expect(current_path).to eq( "#{path_to(page_name)}" )
end

Then /^Show me the page$/ do
  save_and_open_screenshot
end

Then(/^There should be a link to "(.*?)"$/) do |link|
  expect(page).to have_link link
end

module WithinHelpers
  def with_scope locator
    locator ? within(locator) { yield } : yield
  end
end
World WithinHelpers

And(/^I wait for a few seconds$/) do
  sleep 10 # Hang out for long operations, like for Fedora
end