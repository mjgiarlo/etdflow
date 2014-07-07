# Generalized step definitions for interacting with forms

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"?$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )check "([^"]*)"?$/ do |field|
  check(field)
end

When /^(?:|I )press "([^"]*)"?$/ do |button|
  click_button(button)
end

When(/^I select '(.*?)' from '(.*?)'$/) do |value, field|
  select(value, :from => field)
end
