# -*- encoding : utf-8 -*-

Then /^I should see call for application '([^']*)'$/ do |name|
  section(name).should have_content name
end

Then /^I should see call for application '([^']*)' with description '([^']*)':$/ do |name, description, table|
  within section(name) do
    table.hashes.each do |row|
      find('h4', text: row[:label]).find(:xpath, './following-sibling::p[1]').should have_content row[:value]
    end
  end
end

def check_personal_details(container_selector, person_attributes)
  check_that_contains_values container_selector, person_attributes[:first_name], person_attributes[:last_name],
                             person_attributes[:phone], person_attributes[:email]
end

Then /^I should see ([^"]*)'s name, phone number and email\-address in the application form$/ do |student|
  check_personal_details '.applicant-details', FactoryGirl.attributes_for(student.tr(' ', '_').downcase.to_sym)
end

Then /^I should see my own name, phone number and email\-address in the confirmation dialog$/ do
  check_personal_details '#application-sent .applicant-details', FactoryGirl.attributes_for(:student_martti)
end

Then /^I should see (\d+) persons in '([^']*)'$/ do |person_count, title|
  all(".organ-members:contains('#{title}') .member-card").count.should == person_count.to_i
end

def applicant(name)
  find ".applicants .member-card:contains('#{name}')"
end

Then /^I set applicant '([^']*)' as '([^']*)'$/ do |name, position|
  case position
  when 'Jäsen'
    css_class = 'member'
  when 'Varajäsen'
    css_class = 'deputy'
  else
    raise "Unknown position: #{position}"
  end
  member_slot = all(".member-card-empty.#{css_class}").first
  applicant(name).drag_to member_slot
end

When /^I press the edit icon within call details$/ do
  within '#call-details' do
    find('.edit-icon').click
  end
end
