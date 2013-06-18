Then /^I should see "([^"]*)" listed as member$/ do |arg|
  check_that_contains_values("ul.members", arg)
end
