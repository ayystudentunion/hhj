Given %r/^I am viewing the front page$/ do
  visit('/')
end

When %r/^I press "([^"]*)"$/ do |text|
  click_on text
end

Then %r/^show me the page$/ do
  save_and_open_page
end

When %r/^I follow the link "([^"]*)"$/ do |link_title|
  click_link link_title
end
