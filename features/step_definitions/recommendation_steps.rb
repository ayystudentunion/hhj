Given /^there is an application with deputy for "([^"]*)"$/ do |title|
  call = Call.where(title: title).first
  primary_application = FactoryGirl.create :helsinki_uni_board_application, user: FactoryGirl.create(:helsinki_uni_student_pekka), call: call
  FactoryGirl.create :helsinki_uni_board_application, member: primary_application, call: call, user: FactoryGirl.create(:helsinki_uni_student_anna), position: :position_deputy
end
