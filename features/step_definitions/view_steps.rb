
def check_view_values(container, table)
  table.hashes.each do |row|
    container.find(".label:contains('#{row[:label]}') + span").should have_content row[:value]
  end
end

def check_details(details_selector, title, description, table)
  details = page.find details_selector, :visible => true
  details.find("h2").should have_content title
  if not description.nil? and not table.nil?
    details.should have_content description
    check_view_values details, table
  end
end

def check_that_contains_values(container_selector, *values)
  values.each{ |value| find(container_selector).should have_content value }
end

Then %r/^I should see dialog '([^']*)'(?: with text '([^']*)')?:$/ do |*args|
  title, text, table = args
  content = find(".modal .content")
  content.find("h2:contains('#{title}')")
  content.find("textarea:contains('#{text}')") unless text.nil?
  check_view_values content, table
end

Then %r/^I should see level 3 header "([^"]*)"$/ do |text|
  find("h3:contains('#{text}')")
end

Then /^I should see (\d*) buttons{0,1} with text "([^"]*)"$/ do |number, text|
  page.all("input[value=#{text}]").count.should == number.to_i
end

Given /^I refresh the page$/ do
  visit current_url
end

Then /^I select "([^"]*)" as the member I want to be deputy of$/ do |value|
  select(value, :from => "position_application_member_id")
end

Then /^I should see "([^"]*)" among the applications listing$/ do |text|
  page.find('#recommendations').should have_content(text)
end

Then /^should see "([^"]*)" within the applicant details$/ do |text|
  page.find('.applicant-details').should have_content(text)
end

