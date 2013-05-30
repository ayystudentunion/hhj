
Given %r/^I am logged in as a student union employee$/ do
  FactoryGirl.create :eija
  visit "/dev_login?user=eija"
end

Given %r/^I am logged in as a member of university staff$/ do
  FactoryGirl.create :aaro
  visit "/dev_login?user=aaro"
end

Given %r/^I am logged in as a student$/ do
  FactoryGirl.create :student_martti
  visit "/dev_login?user=student_martti"
end

Then %r/^I should see logged in user "([^"]*)" with mail "([^"]*)" and phone "([^"]*)"$/ do |name, email, phone|
  check_that_contains_values '.profile-info', name, phone, email
  check_that_contains_values '.login-info', name
end

Given /^there is a student union employee marked as contactable$/ do
  employee = User.where(role: :role_union_employee).first
  employee.update_attributes!(contactable: true)
end
