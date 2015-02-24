# -*- encoding : utf-8 -*-

require 'rails_helper'

describe Organ do

  organ = FactoryGirl.create(:tasa_arvotyoryhma)

  it 'can add members' do
    deputy_user = FactoryGirl.create(:student_martti)
    member_user = FactoryGirl.create(:student_topias)
    member = FactoryGirl.create(:kirjakerho_application, selected_as: :position_member, user: member_user)
    deputy = FactoryGirl.create(:kirjakerho_application, selected_as: :position_deputy, member: member, user: deputy_user)
    members_without_deputy = FactoryGirl.create_list(:kirjakerho_application, 2, selected_as: :position_member)
    deputy_without_member = FactoryGirl.create(:kirjakerho_application, selected_as: :position_deputy)
    not_selected = FactoryGirl.create(:kirjakerho_application)

    organ.add_selected_members! FactoryGirl.create(:lukurinki)

    organ.reload_relations
    organ.members.count.should == 5
    organ.members.where(position: :position_deputy).count.should == 2
    organ.members.where(position: :position_member).count.should == 3
    organ.members.where(user_id: deputy_user._id).first.member.user._id.should == member_user._id
  end
end
