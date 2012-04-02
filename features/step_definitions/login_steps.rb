def check_profile_info_contains(value)
  find('.profile-info').should have_content value
end

def check_login_info_contains(value)
  find('.login-info').should have_content value
end

Given %r/^I am logged in as a student union employee$/ do

end

Then %r/^I should see logged in user "([^"]*)" with mail "([^"]*)" and phone "([^"]*)"$/ do |name, email, phone|
  check_profile_info_contains name
  check_profile_info_contains email
  check_profile_info_contains phone
  check_login_info_contains name
end


