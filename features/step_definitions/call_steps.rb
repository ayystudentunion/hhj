Then %r/^I should see call for application '([^']*)' with description '([^']*)':$/ do |call_name, description, table|
  check_details '.call-details', call_name, description, table
end
