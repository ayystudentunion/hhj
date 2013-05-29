Given /^there is an application for "([^"]*)"$/ do |title|
  call = Call.where(title: title).first
  FactoryGirl.create :kirjakerho_application, user: FactoryGirl.create(:student_martti), call: call
end
