require 'spec_helper'

describe Alliance do
  it 'should return empty when there are no member applications' do
    a = FactoryGirl.create :alliance
    a.member_applications.should == []
  end

  it 'should return applications if any exist' do
    am = FactoryGirl.create :alliance_membership
    am.user_name.should == 'Maija Hyyemployee'
    am.alliance.member_applications.count.should == 1
  end
end
