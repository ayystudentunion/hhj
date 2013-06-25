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
    respond_to do |format|
      format.fragment
    end
  end

  def create
    @alliance = @user.alliances.create! params[:alliance]
    @alliance.alliance_memberships.each{|membership| AllianceMailer.confirmation_email(membership, @university, university_path(university: @university.key))}
  end

end
