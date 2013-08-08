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

Given /^I am logged in as a helsinki university student ([^"]*)$/ do |name|
  user = "helsinki_uni_student_" + name.sub(" ", "_").downcase
  FactoryGirl.create user
  visit "/dev_login?user=#{user}"
end
