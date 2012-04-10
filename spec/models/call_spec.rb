# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Call do

  application = FactoryGirl.create(:kirjakerho_application)
  call = application.call
  call.position_applications.each do | application |
    application.selected_as.should == nil
  end

  it 'can handle empty hash and nil as results to position applications' do
    call.set_results({})
    call.set_results nil
    call.reload_relations
    call.position_applications.each do | application |
      application.selected_as.should == nil
    end

  end

  it 'can set results to position applications' do
    applications = FactoryGirl.create_list(:kirjakerho_application, 7)

    call.set_results( Hash[
        applications[0..2].map{|a| [a.id.to_s, :position_deputy]  } +
        applications[3..4].map{|a| [a.id.to_s, :position_member]  } +
        applications[5..5].map{|a| [a.id.to_s, :position_rejected] }
    ])

    call.reload_relations
    call.position_applications.where(selected_as: :position_deputy).count.should == 3
    call.position_applications.where(selected_as: :position_member).count.should == 2
    call.position_applications.where(selected_as: :position_rejected).count.should == 1
    call.position_applications.where(selected_as: nil).count.should == 1 # Don't change applications whose id is not in set_results args
  end

end
