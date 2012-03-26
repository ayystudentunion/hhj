Given /^I am viewing the front page$/ do
  visit('/')
end

When /^I press "([^"]*)"$/ do |element_name|
  click_link element_name
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I follow the link "([^"]*)"$/ do |link_title|
  click_link link_title
end
