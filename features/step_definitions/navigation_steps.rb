Given /^I am viewing the front page$/ do
  visit('/')
end

When /^I press "([^"]*)"$/ do |text|
  form_button = first("input[value='#{text}']")
  if form_button
    form_button.click
  else
    click_link text
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I follow the link "([^"]*)"$/ do |link_title|
  click_link link_title
end
