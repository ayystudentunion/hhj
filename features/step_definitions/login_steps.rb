def check_profile_contains(selector, *values)
  values.each{ |value| find(selector).should have_content value }
end

Given %r/^I am logged in as a student union employee$/ do

end

Then %r/^I should see logged in user "([^"]*)" with mail "([^"]*)" and phone "([^"]*)"$/ do |name, email, phone|
  check_profile_contains '.profile-info', name, phone, email
  check_profile_contains '.login-info', name
end


