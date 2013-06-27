Given /^there is an application with deputy for "([^"]*)"$/ do |title|
  call = Call.where(title: title).first
  primary_application = FactoryGirl.create :kirjakerho_application, user: FactoryGirl.create(:student_martti), call: call
  FactoryGirl.create :kirjakerho_application, member: primary_application, call: call, user: FactoryGirl.create(:student_tiina), position: :position_deputy
end
