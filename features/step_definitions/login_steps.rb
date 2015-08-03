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

Given /^I am logged in as user ([^"]*)$/ do |user|
  factory = user.underscore.gsub(" ", "_")
  FactoryGirl.create factory
  visit "/dev_login?user=#{factory}"
end

Given /^I am logged in as helsinki university student ([^"]*)$/ do |name|
  user = "helsinki_uni_student_" + name.gsub(" ", "_").downcase
  FactoryGirl.create user
  visit "/dev_login?user=#{user}"
end

Given /^I am logged in as a Helsinki university students' union employee$/ do
  FactoryGirl.create :helsinki_uni_student_union_employee
  visit "/dev_login?user=helsinki_uni_student_union_employee"
end

And /^I logout$/ do
  visit "/dev_logout"
end
