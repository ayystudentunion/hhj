
Given %r/^I am logged in as a student union employee$/ do
end

Given %r/^I am logged in as a student$/ do
end

Then %r/^I should see logged in user "([^"]*)" with mail "([^"]*)" and phone "([^"]*)"$/ do |name, email, phone|
  check_that_contains_values '.profile-info', name, phone, email
  check_that_contains_values '.login-info', name
end


