require 'spec_helper'

describe PositionApplication do

  context '(when checking eligibility for election)' do
    it 'is eligible if there are no rules set' do
      application = FactoryGirl.create(:kirjakerho_application)
      expect(application.eligible?).to eq(true)
    end

    it 'can check eligibility comparing a edu person field to a list of valid values' do
      application = FactoryGirl.create(:kirjakerho_application)
      application.call.eligibility_rule_set = FactoryGirl.create(:accept_only_martti_to_lukurinki)
      application.user.unset(:edu_data)
      expect(application.eligible?).to eq(false)
      application.user.set(:edu_data, {'A_GIVEN_NAME' => 'Emma'})
      expect(application.eligible?).to eq(false)
      application.user.set(:edu_data, {'A_OTHER' => 'Martti'})
      expect(application.eligible?).to eq(false)
      application.user.set(:edu_data, {})
      expect(application.eligible?).to eq(false)
      application.user.set(:edu_data, nil)
      expect(application.eligible?).to eq(false)

      application.user.set(:edu_data, {'A_GIVEN_NAME' => 'Martti'})
      expect(application.eligible?).to eq(true)
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
        expect(a.selected_as).to eq(nil)
      end
    end

    it 'can mark multiple applications according to selections' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 7)

      applications[0..2].each{ |a| a.set_position!(selected_as: :position_deputy) }
      applications[3..4].each{ |a| a.set_position!(selected_as: :position_member) }
      applications[5..5].each{ |a| a.set_position!(selected_as: nil) }

      expect(PositionApplication.where(selected_as: :position_deputy).count).to eq(3)
      expect(PositionApplication.where(selected_as: :position_member).count).to eq(2)
      expect(PositionApplication.where(selected_as: nil).count).to eq(2)
    end

    it 'can set member for deputy and deputy for member' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 2)

      applications[0].set_position!(selected_as: :position_member)
      applications[1].set_position!(selected_as: :position_deputy, member: applications[0].id.to_s)

      expect(PositionApplication.where(selected_as: :position_deputy).first.member.id.to_s).to eq(applications[0].id.to_s)
      expect(PositionApplication.where(selected_as: :position_member).first.deputy.id.to_s).to eq(applications[1].id.to_s)

      applications[0].reload.set_position!(selected_as: :position_deputy)
      applications[1].reload.set_position!(selected_as: :position_member, deputy: applications[0].id.to_s)

      expect(PositionApplication.where(selected_as: :position_deputy).first.member.id.to_s).to eq(applications[1].id.to_s)
      expect(PositionApplication.where(selected_as: :position_member).first.deputy.id.to_s).to eq(applications[0].id.to_s)
    end


    it 'clears old deputy-member relations when deputy changes' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 3)

      applications[0].set_position!(selected_as: :position_member)
      applications[1].set_position!(selected_as: :position_deputy, member: applications[0].id.to_s)
      applications[2].set_position!(selected_as: :position_deputy, member: applications[0].id.to_s)

      expect(PositionApplication.find(applications[0].id).deputy.id).to eq(applications[2].id)
      expect(PositionApplication.find(applications[0].id).member).to eq(nil)
      expect(PositionApplication.find(applications[1].id).member).to eq(nil)
      expect(PositionApplication.find(applications[1].id).deputy).to eq(nil)
      expect(PositionApplication.find(applications[2].id).member.id).to eq(applications[0].id)
      expect(PositionApplication.find(applications[2].id).deputy).to eq(nil)
    end

    it 'can reset deputy/member' do
      applications = FactoryGirl.create_list(:kirjakerho_application, 2)

      applications[0].set_position!(selected_as: :position_deputy)
      applications[1].set_position!(selected_as: :position_member, deputy: applications[0].id.to_s)
      applications[0].reload.set_position!(selected_as: :position_deputy)

      PositionApplication.all.each do |position_application|
        expect(position_application.deputy).to eq(nil)
        expect(position_application.member).to eq(nil)
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
      expect(@application).not_to be_admissible
      2.times {FactoryGirl.create(:recommendation, position_application: @application)}
      expect(@application).to be_admissible
    end

    it "is falsefor applications with a insufficient number of recommendations" do
      expect(@application).to be_admissible
      @top_organization.recommendations_threshold = 1
      @top_organization.save
      expect(@application).not_to be_admissible
    end

  end
end
