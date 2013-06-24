class PositionApplicationsController < ApplicationController

  before_filter :authorize_call_admin, except: [:new, :create, :alliance_confirmation]
  before_filter :authorize_applicant, only: [:new, :create]
  before_filter(except: :alliance_confirmation) { |c| c.find_call_from_current_university :call_id }
  before_filter :find_application_from_call, except: [:index, :new, :create, :alliance_confirmation]

  def index
  end

  def show
    respond_to do |format|
      format.fragment
    end
  end

  def new
    @position_application = @call.position_applications.build(user_id: @user._id)
    respond_to do |format|
      format.fragment
    end
  end

  def edit
  end

  def create
    @position_application = @call.position_applications.create! params[:position_application]
  end

  def update
    @position_application.update_attributes! params[:position_application]
    respond_to do |format|
      format.json { render :json => @position_application }
    end
  end

  def destroy
  end

  def alliance_confirmation
    @position_application = PositionApplication.find(params[:position_application_id])
    @university = @position_application.call.organ.organization.root
    if @user && @user == @position_application.user
      @position_application.update_attributes(alliance_confirmed: true)
      flash[:success] = "Vaaliliittoon kuuluminen vahvistettu."
    else
      flash[:error] = "Ei voitu vahvistaa"
    end
    respond_to do |format|
      format.html { redirect_to university_path(university: @university.key) }
      format.js {  }
    end

  end

  protected

  def find_application_from_call
    @position_application = @call.position_applications.find(params[:id])
  end

end
