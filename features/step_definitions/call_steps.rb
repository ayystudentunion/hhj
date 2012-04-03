Then %r/^I should see call for application '([^']*)'(?: with description '([^']*)':)?$/ do |*args|
  name, description, table = args
  check_details '.call-details', name, description, table
end



def check_personal_details(container_selector, person_attributes)
  check_that_contains_values container_selector, person_attributes[:first_name], person_attributes[:last_name],
    person_attributes[:phone], person_attributes[:email]
end

Then %r/^I should see my own name, phone number and email\-address in the application form$/ do
  check_personal_details '.applicant-details', FactoryGirl.attributes_for(:eija)
end

Then %r/^I should see my own name, phone number and email\-address in the confirmation dialog$/ do
  check_personal_details '#application-sent .applicant-details', FactoryGirl.attributes_for(:eija)
end
