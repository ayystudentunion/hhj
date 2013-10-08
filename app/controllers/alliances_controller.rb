class AlliancesController < ApplicationController

  def index
    @alliances = Alliance.all
    respond_to do |format|
      format.html
      format.fragment { render "index", formats: ['html'], layout: false }
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
    @calls = Call.all.find_all{|call| call.administrational? }
    respond_to do |format|
      format.fragment
    end
  end

  def create
    @alliance = @user.alliances.create! params[:alliance].merge(alliance_memberships_attributes(params[:application_ids]))
    @alliance.alliance_memberships.each{|membership| AllianceMailer.confirmation_email(membership, @university, university_path(university: @university.key)).deliver }
  end

  def alliance_memberships_attributes(application_ids)
    with_coapplicants = (application_ids | application_ids.map{|id| PositionApplication.find(id).member_id})
    {"alliance_memberships_attributes" => with_coapplicants.find_all(&:present?).map{|id| {"position_application_id" => id} }}
  end

end
