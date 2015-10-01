require 'spec_helper'

describe ApplicationMailer do

  describe 'sent email' do

    it 'should create an email' do
      user1 = FactoryGirl.create(:helsinki_uni_student_anna)
      application = FactoryGirl.create(:helsinki_uni_board_application, user: user1, position: :position_member)
      ApplicationMailer.sent_email(application).deliver_now.should_not nil
    end
  end
end
