Given /^I am viewing the front page$/ do
  visit('/')
end

When /^I press "([^"]*)"$/ do |element_name|
  click_link element_name
end
