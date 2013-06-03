require 'spec_helper'

describe PositionApplication do

  context '(when checking eligibility for election)' do
    it 'is eligible if there are no rules set' do
      application = FactoryGirl.create(:kirjakerho_application)
      application.eligible?.should == true
    end

    it 'can check eligibility comparing a edu person field to a list of valid values' do
      application = FactoryGirl.create(:kirjakerho_application)
      application.call.eligibility_rule_set = FactoryGirl.create(:accept_only_martti_to_lukurinki)
      application.user.unset(:edu_data)
      application.eligible?.should == false
      application.user.set(:edu_data, {'A_GIVEN_NAME' => 'Emma'})
      application.eligible?.should == false
      application.user.set(:edu_data, {'A_OTHER' => 'Martti'})
      application.eligible?.should == false
      application.user.set(:edu_data, {})
      application.eligible?.should == false
      application.user.set(:edu_data, nil)
      application.eligible?.should == false

      application.user.set(:edu_data, {'A_GIVEN_NAME' => 'Martti'})
      application.eligible?.should == true
    end
  end

  context '(when marking applicants for selection)' do

    PositionApplication.all.each do | application |
      application.selected_as.should == nil
    end

    check_all_self_references_are_nil = lambda do
      PositionApplication.all.each do |position_application|
        position_application.deputy.should == nil
        position_application.member.should == nil
      end
    end

    it 'can mark applicant as not selected' do
      application = FactoryGirl.create(:kirjakerho_application)
      application.set_position!(selected_as: nil)
      PositionApplication.all.each do |a|
        a.selected_as.should == nil
      end
    end

    it 'can mark multiple applications according to selections' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 7)

      applications[0..2].each{ |a| a.set_position!(selected_as: :position_deputy) }
      applications[3..4].each{ |a| a.set_position!(selected_as: :position_member) }
      applications[5..5].each{ |a| a.set_position!(selected_as: nil) }

      PositionApplication.where(selected_as: :position_deputy).count.should == 3
      PositionApplication.where(selected_as: :position_member).count.should == 2
      PositionApplication.where(selected_as: nil).count.should == 2
    end

    it 'can set member for deputy and deputy for member' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 2)

      applications[0].set_position!(selected_as: :position_member)
      applications[1].set_position!(selected_as: :position_deputy, member: applications[0].id.to_s)

      PositionApplication.where(selected_as: :position_deputy).first.member.id.to_s.should == applications[0].id.to_s
      PositionApplication.where(selected_as: :position_member).first.deputy.id.to_s.should == applications[1].id.to_s

      applications[0].reload.set_position!(selected_as: :position_deputy)
      applications[1].reload.set_position!(selected_as: :position_member, deputy: applications[0].id.to_s)

      PositionApplication.where(selected_as: :position_deputy).first.member.id.to_s.should == applications[1].id.to_s
      PositionApplication.where(selected_as: :position_member).first.deputy.id.to_s.should == applications[0].id.to_s
    end


    it 'clears old deputy-member relations when deputy changes' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 3)

      applications[0].set_position!(selected_as: :position_member)
      applications[1].set_position!(selected_as: :position_deputy, member: applications[0].id.to_s)
      applications[2].set_position!(selected_as: :position_deputy, member: applications[0].id.to_s)

      PositionApplication.find(applications[0].id).deputy.id.should == applications[2].id
      PositionApplication.find(applications[0].id).member.should == nil
      PositionApplication.find(applications[1].id).member.should == nil
      PositionApplication.find(applications[1].id).deputy.should == nil
      PositionApplication.find(applications[2].id).member.id.should == applications[0].id
      PositionApplication.find(applications[2].id).deputy.should == nil
    end

    it 'can reset deputy/member' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 2)

      applications[0].set_position!(selected_as: :position_deputy)
      applications[1].set_position!(selected_as: :position_member, deputy: applications[0].id.to_s)
      applications[0].reload.set_position!(selected_as: :position_deputy)

      PositionApplication.all.each do |position_application|
        position_application.deputy.should == nil
        position_application.member.should == nil
      end
      check_all_self_references_are_nil.call
    end

    it 'resets deputy/member if unselected' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 2)

      applications[0].set_position!(selected_as: :position_deputy)
      applications[1].set_position!(selected_as: :position_member, deputy: applications[0].id.to_s)
      applications[0].reload.set_position!(selected_as: nil)
      check_all_self_references_are_nil.call
    end
  end

  describe "#admissible?" do

    before(:each) do
      @application = FactoryGirl.create :kirjakerho_application, user: FactoryGirl.create(:student_martti)
      @top_organization = @application.call.organ.organization.root
    end

    it "is true for applications with a sufficient number of recommendations" do
      @top_organization.recommendations_threshold = 1
      @top_organization.save
      @application.should_not be_admissible
      2.times {FactoryGirl.create(:recommendation, position_application: @application)}
      @application.should be_admissible
    end

    it "is falsefor applications with a insufficient number of recommendations" do
      @application.should be_admissible
      @top_organization.recommendations_threshold = 1
      @top_organization.save
      @application.should_not be_admissible
    end

  end
end
