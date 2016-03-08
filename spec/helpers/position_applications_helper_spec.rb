# -*- encoding : utf-8 -*-

require 'spec_helper'

describe PositionApplicationsHelper do
  describe 'rearrange_pairs_adjacently method' do
    before(:each) do
      user1 = FactoryGirl.create(:helsinki_uni_student_anna)
      user2 = FactoryGirl.create(:helsinki_uni_student_pekka)
      user3 = FactoryGirl.create(:helsinki_uni_student_tiina)

      @member = FactoryGirl.create(:helsinki_uni_board_application, user: user1, position: :position_member)
      @deputy = FactoryGirl.create(:helsinki_uni_board_application, user: user2, position: :position_deputy, member: @member)
      @pairless = FactoryGirl.create(:helsinki_uni_board_application, user: user3, position: :position_member)
    end

    it 'rearranges the application correctly' do
      arranged = rearrange_pairs_adjacently([@deputy, @member, @pairless])
      arranged.should == [@member, @deputy, @pairless]
    end

    it 'rearranges the application correctly' do
      arranged = rearrange_pairs_adjacently([@deputy, @pairless, @member])
      arranged.should == [@member, @deputy, @pairless]
    end
  end
end
