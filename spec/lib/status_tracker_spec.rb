require 'spec_helper'

describe StatusTracker do
  it 'should count them' do
    m1 = FactoryGirl.create :alliance_membership
    m2 = FactoryGirl.create :alliance_membership

    pa = m2.position_application
    call = pa.call
    u = call.university
    u.recommendations_threshold = 1
    u.save!

    FactoryGirl.create :recommendation, position_application: pa

    StatusTracker.global_success.should == 1
  end
end
