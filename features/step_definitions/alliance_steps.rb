Then /^I should see "([^"]*)" listed as member$/ do |arg|
  check_that_contains_values("ul.members", arg)
end

Given /^someone has added my application to an electoral alliance$/ do
  user = User.find('4f7963bf91bc2bc1f6000002')
  call = Call.first
  application = FactoryGirl.create :position_application, user: user, call: call
  alliance = FactoryGirl.create(:alliance)
  FactoryGirl.create(:alliance_membership, position_application: application, alliance: alliance)

end

Then /^I should not see "([^"]*)" in the sidebar$/ do |text|
  sidebar = page.find('#sidebar')
  sidebar.should have_no_content(text)
end

