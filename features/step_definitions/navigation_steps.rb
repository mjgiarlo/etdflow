# Generalized step definitions for navigation
require 'uri'

Given /^I am on (.*)$/ do |page_name|
  basic_auth_and_visit path_to(page_name)
end

When /^I go to (.*)$/ do |page_name|
  basic_auth_and_visit path_to(page_name)
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link link
end

Then /^I should be on (.*)$/ do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq( "#{path_to(page_name)}" )
end
