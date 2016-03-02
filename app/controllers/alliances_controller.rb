class AlliancesController < ApplicationController
  def index
    @alliances = Alliance.active
    respond_to do |format|
      format.html
      format.fragment { render 'index', formats: ['html'], layout: false }
    end
  end

  def show
    @alliance = Alliance.find(params[:id])
    respond_to do |format|
      format.fragment
    end
  end

  def new
    @alliance = @user.alliances.build
    @calls = Call.open.find_all(&:administrational?)
    respond_to do |format|
      format.fragment
    end
  end

  def create
    @alliance = @user.alliances.create! params[:alliance].merge(alliance_memberships_attributes(params[:application_ids]))
    @alliance.alliance_memberships.each do |membership|
      url = university_url(university: @university.key)
      AllianceMailer::Job.new.async.perform(membership.id, @university.id, url)
    end
  end

  def alliance_memberships_attributes(application_ids)
    if application_ids
      with_coapplicants = (application_ids | application_ids.map { |id| PositionApplication.find(id).member_id })
      { 'alliance_memberships_attributes' => with_coapplicants.find_all(&:present?).map { |id| { 'position_application_id' => id } } }
    else
      {}
    end
  end
end
