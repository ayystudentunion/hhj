# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Call do

  it 'can handle empty hash as results to position applications' do
    application = FactoryGirl.create(:kirjakerho_application)
    call = application.call
    call.position_applications.each do | application |
      application.selected_as.should == nil
    end

    call.set_results({})

    call.reload_relations
    call.position_applications.each do | application |
      application.selected_as.should == nil
    end

  end

  it 'can set results to position applications' do
    application = FactoryGirl.create(:kirjakerho_application)
    call = application.call
    call.position_applications.each do | application |
      application.selected_as.should == nil
    end

    call.set_results position_deputy: call.position_applications.map(&:_id)

    call.reload_relations
    call.position_applications.each do | application |
      puts application.selected_as
      application.selected_as.should == :position_deputy
    end

  end
end
