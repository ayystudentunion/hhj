# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Call do

  application = FactoryGirl.create(:kirjakerho_application)
  call = application.call
  call.position_applications.each do | application |
    application.selected_as.should == nil
  end

  check_all_self_references_are_nil = lambda do
    call.reload_relations
    call.position_applications.each do |position_application|
      position_application.my_deputy.should == nil
      position_application.my_member.should == nil
    end
  end

  it 'can handle empty hash and nil as results to position applications' do
    call.set_selected!({}, nil)
    call.set_selected! nil, nil
    call.reload_relations
    call.position_applications.each do | application |
      application.selected_as.should == nil
      application.my_member = nil
      application.my_deputy = nil
    end

  end

  it 'can set results to position applications' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 7)

    applications[0..2].each{ |a| call.set_selected!({a.id.to_s => :position_deputy}, nil) }
    applications[3..4].each{ |a| call.set_selected!({a.id.to_s => :position_member}, nil) }
    applications[5..5].each{ |a| call.set_selected!({a.id.to_s => nil}, nil) }

    call.reload_relations
    call.position_applications.where(selected_as: :position_deputy).count.should == 3
    call.position_applications.where(selected_as: :position_member).count.should == 2
    call.position_applications.where(selected_as: nil).count.should == 2
  end

  it 'can set member for deputy' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 2)

    call.set_selected!({applications[0].id.to_s => :position_member}, nil)
    call.set_selected!({applications[1].id.to_s => :position_deputy}, applications[0].id.to_s)

    call.reload_relations
    call.position_applications.where(selected_as: :position_deputy).first.my_member.id.to_s.should == applications[0].id.to_s
    call.position_applications.where(selected_as: :position_member).first.my_deputy.id.to_s.should == applications[1].id.to_s
  end

  it 'clears old relations when deputy changes' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 3)

    call.set_selected!({applications[0].id.to_s => :position_member}, nil)
    call.set_selected!({applications[1].id.to_s => :position_deputy}, applications[0].id.to_s)
    call.set_selected!({applications[2].id.to_s => :position_deputy}, applications[0].id.to_s)

    call.reload_relations
    call.position_applications.find(applications[0].id).my_deputy.id.should == applications[2].id
    call.position_applications.find(applications[0].id).my_member.should == nil
    call.position_applications.find(applications[1].id).my_member.should == nil
    call.position_applications.find(applications[1].id).my_deputy.should == nil
    call.position_applications.find(applications[2].id).my_member.id.should == applications[0].id
    call.position_applications.find(applications[2].id).my_deputy.should == nil
  end

  it 'can reset deputy/member' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 2)

    call.set_selected!({applications[0].id.to_s => :position_deputy}, nil)
    call.set_selected!({applications[1].id.to_s => :position_member}, applications[0].id.to_s)
    call.set_selected!({applications[0].id.to_s => :position_deputy}, nil)

    check_all_self_references_are_nil.call
  end

  it 'resets deputy/member if unselected' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 2)

    call.set_selected!({applications[0].id.to_s => :position_deputy}, nil)
    call.set_selected!({applications[1].id.to_s => :position_member}, applications[0].id.to_s)
    call.set_selected!({applications[0].id.to_s => nil}, nil)

    check_all_self_references_are_nil.call
  end


end
