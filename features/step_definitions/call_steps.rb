Then %r/^I should see call for application '([^']*)'(?: with description '([^']*)':)?$/ do |call_name, description, table|
  check_details '.call-details', call_name, description, table
end

def check_personal_details(person_attributes)
  check_that_contains_values '.applicant-details', person_attributes[:first_name], person_attributes[:last_name],
    person_attributes[:phone], person_attributes[:email]
end

Then %r/^I should see my own name, phone number and email\-address in the application form$/ do
  check_personal_details FactoryGirl.attributes_for(:eija)
end

Then %r/^I should see my own name, phone number and email\-address in the confirmation dialog$/ do
  check_personal_details FactoryGirl.attributes_for(:eija)
end
