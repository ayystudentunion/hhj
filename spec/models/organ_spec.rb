# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Organ do

  organ = FactoryGirl.create(:tasa_arvotyoryhma)

  it 'can add members' do
    deputies = FactoryGirl.create_list(:kirjakerho_application, 3, selected_as: :position_deputy)
    members = FactoryGirl.create_list(:kirjakerho_application, 2, selected_as: :position_member)
    not_selected = FactoryGirl.create(:kirjakerho_application)

    organ.add_selected_members! not_selected.call

    organ.reload_relations
    organ.members.count.should == 5
    organ.members.where(position: :position_deputy).count.should == 3
    organ.members.where(position: :position_member).count.should == 2
  end
end
