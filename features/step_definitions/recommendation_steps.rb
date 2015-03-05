Given /^there is an application with deputy for "([^"]*)"$/ do |title|
  call = Call.where(title: title).first
  primary_application = FactoryGirl.create :helsinki_uni_board_application, user: FactoryGirl.create(:helsinki_uni_student_pekka), call: call
  FactoryGirl.create :helsinki_uni_board_application, member: primary_application, call: call, user: FactoryGirl.create(:helsinki_uni_student_anna), position: :position_deputy
end

Given /^the member application has one confirmed alliance and one unconfirmed alliance$/ do
  expect(PositionApplication.where(position: :position_member).count).to eq(1)
  application = PositionApplication.where(position: :position_member).first
  alliance1 = FactoryGirl.create(:alliance, name: "Alliance1")
  alliance2 = FactoryGirl.create(:alliance, name: "Alliance2")
  AllianceMembership.create(position_application: application, alliance: alliance1, confirmed: false)
  AllianceMembership.create(position_application: application, alliance: alliance2, confirmed: true)
end
