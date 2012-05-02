Then %r/^I should see call for application '([^']*)'(?: with description '([^']*)':)?$/ do |*args|
  name, description, table = args
  check_details '.call-details', name, description, table
end

def check_personal_details(container_selector, person_attributes)
  check_that_contains_values container_selector, person_attributes[:first_name], person_attributes[:last_name],
    person_attributes[:phone], person_attributes[:email]
end

Then %r/^I should see my own name, phone number and email\-address in the application form$/ do
  check_personal_details '.applicant-details', FactoryGirl.attributes_for(:student_martti)
end

Then %r/^I should see my own name, phone number and email\-address in the confirmation dialog$/ do
  check_personal_details '#application-sent .applicant-details', FactoryGirl.attributes_for(:student_martti)
end

Then %r/^I should see (\d+) persons in '([^']*)'$/ do |person_count, title|
  all(".organ-members:contains('#{title}') .member-card" ).count().should == person_count.to_i
end

def applicant(name)
  find ".applicants .member-card:contains('#{name}')"
end

Then %r/^I set applicant '([^']*)' as '([^']*)'$/ do |name, position|
  member_slot = find ".member-card-empty:contains('#{position.downcase}')"
  applicant(name).drag_to member_slot
end
