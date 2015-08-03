require 'spec_helper'

describe Member do

  it 'should return current member accordingly' do
    m = FactoryGirl.create :member
    m.respond_to?("current_member").should be true
    m.current.should be true
    #m.current_member.should_not be (nil)
    m.current = false
    m.save!
    m.current.should be false
    m.current_member.should be (nil)
  end
end
