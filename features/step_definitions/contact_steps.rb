Given /^there is a student union employee marked as contactable and contactable by phone$/ do
  employee = User.where(role: :role_union_employee).first
  employee.update_attributes!(contactable: true, contactable_by_phone: true)
end

Given /^there is a contact for an organization$/ do
  FactoryGirl.create(:contact)
end

Then /^I should see "([^"]*)" as contact info$/ do |text|
  page.find('.contact-info').should have_content(text)
end

Then /^I should not see "([^"]*)" as contact info$/ do |text|
  page.find('.contact-info').should_not have_content(text)
end

When /^somebody creates an ongoing call$/ do
  call = TestSingletons.lukurinki
  call.update_attributes!(date_start: (Time.zone.now - 1.day).to_date, date_end: (Time.zone.now + 1.day).to_date)
end

Then /^I fill in name, email and phone number fields with "([^"]*)", "([^"]*)" and "([^"]*)"$/ do |arg1, arg2, arg3|
  within '.new_contact' do
    fill_in :contact_email, with: arg2
    fill_in 'contact_name', with: arg1
    fill_in 'contact_phone_number', with: arg3
  end
end

When /^I press the "Add contact" button$/ do
  page.find('a.sidebar-button.btn.create-new-contact.js-modal').click
end

When /^I press the save button$/ do
  page.find('.submit.close-modal.btn').click
end

