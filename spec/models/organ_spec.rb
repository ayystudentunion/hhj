# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Organ do

  organ = FactoryGirl.create(:tasa_arvotyoryhma)

  it 'can handle empty hash and nil for adding members' do
    organ.add_members_from_applications({})
    organ.add_members_from_applications nil
    organ.reload_relations
    organ.members.count.should == 0
  end

  it 'can add members' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 7)

    organ.add_members_from_applications(
      position_deputy: applications[0..2].map(&:_id),
      position_member: applications[3..4].map(&:_id),
      position_rejected: [ applications[5]._id ],
    )

    organ.reload_relations
    organ.members.count.should == 5
    organ.members.where(position: :position_deputy).count.should == 3
    organ.members.where(position: :position_member).count.should == 2
  end
end
