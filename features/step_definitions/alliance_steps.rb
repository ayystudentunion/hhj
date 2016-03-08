Then /^I should see "([^"]*)" listed as member$/ do |arg|
  check_that_contains_values('ul.members', arg)
end

Given /^someone has added my application to an electoral alliance called "([^"]*)"$/ do |name|
  user = User.find('4f7963bf91bc2bc1f6000077')
  call = Call.first
  application = FactoryGirl.create :position_application, user: user, call: call
  alliance = FactoryGirl.create(:alliance, name: name)
  FactoryGirl.create(:alliance_membership, position_application: application, alliance: alliance)
end

Then /^I should not see "([^"]*)" in the sidebar$/ do |text|
  sidebar = page.find('#sidebar')
  sidebar.should have_no_content(text)
end

Then /^I should see my name among the ([^"]*) members$/ do |group|
  list = page.find("#alliance ##{group}_members")
  list.should have_content('Anna Kainulainen')
end

Then /^I should not see my name among the ([^"]*) members$/ do |group|
  list = page.find("#alliance ##{group}_members")
  list.should_not have_content('Anna Kainulainen')
end

Then /^I check "([^"]*)" for call "([^"]*)"$/ do |field, title|
  call = Call.where(title: title).first
  within "#applications-for-call-#{call._id}" do
    check(field)
  end
end

When(/^all alliances have been archived$/) do
  Alliance.update_all(archived: true)
end
