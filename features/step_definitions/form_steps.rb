Then /^I should see form "([^"]*)"$/ do |title|
  page.should have_selector("*:contains('#{title}') ~ form")
end

