Given /^there is a student union employee marked as contactable and contactable by phone$/ do
  employee = User.where(role: :role_union_employee).first
  employee.update_attributes!(contactable: true, contactable_by_phone: true)
end

Then /^I should see "([^"]*)" as contact info$/ do |text|
  page.find(".contact-info").should have_content(text)
end

Then /^I should not see "([^"]*)" as contact info$/ do |text|
  page.find(".contact-info").should_not have_content(text)
end

When /^somebody creates an ongoing call$/ do
  call = FactoryGirl.create(:lukurinki)
  call.update_attributes!(date_start: (Time.zone.now - 1.day).to_date, date_end: (Time.zone.now + 1.day).to_date)
end
