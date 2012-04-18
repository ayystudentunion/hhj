require 'spec_helper'

describe PositionApplication do
  application = FactoryGirl.create(:kirjakerho_application)

  it 'is valid for a call if there are no rules set' do
    application.eligible?.should == true
  end
end
