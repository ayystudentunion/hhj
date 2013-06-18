# -*- encoding : utf-8 -*-

Given %r/^there exist university organization$/ do
  FactoryGirl.create :fysiikan_laitos
  FactoryGirl.create :kemian_laitos
  FactoryGirl.create :kirjasto
end

Given %r/^there are several organs in the system$/ do
  FactoryGirl.create :tasa_arvotyoryhma
  FactoryGirl.create :kirjakerho
end

Given %r/^there exists an organ 'Tasa-arvotyöryhmä'$/ do
  FactoryGirl.create :tasa_arvotyoryhma
end

Given %r/^there is open call for applications called 'Kirjakerhon lukurinki'$/ do
  FactoryGirl.create :lukurinki
end

Given %r/^there is open call for applications called 'Kirjakerhon uimarinki'$/ do
  FactoryGirl.create :uimarinki
end

Given /^there are 3 applications for "([^"]*)"$/ do |title|
  call= Call.where(title: title).first
  call.should be_present
  FactoryGirl.create :position_application, user: FactoryGirl.create(:student_martti), call: call
  FactoryGirl.create :position_application, user: FactoryGirl.create(:student_emma), call: call
  FactoryGirl.create :position_application, user: FactoryGirl.create(:student_topias), call: call
end
