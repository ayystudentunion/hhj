class AlliancesController < ApplicationController

  def index
    @alliances = Alliance.all
    respond_to do |format|
      format.html
      format.fragment { render "index", formats: ['html'], layout: false }
    end
  end

  def show
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
    @alliance.position_applications.each{|application| AllianceMailer.confirmation_email(application, @university, university_path(university: @university.key))}
  end

end
