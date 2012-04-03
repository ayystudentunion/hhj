Then %r/^I should see call for application '([^']*)' with description '([^']*)':$/ do |call_name, description, table|
  check_details '.call-details', call_name, description, table
end

Then %r/^I should see my own name, phone number and email\-address in the application form$/ do
  student_attributes = FactoryGirl.attributes_for(:eija)
  check_that_contains_values '.applicant-details', student_attributes[:first_name], student_attributes[:last_name],
    student_attributes[:phone], student_attributes[:email]
end
