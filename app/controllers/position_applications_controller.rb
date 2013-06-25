class PositionApplicationsController < ApplicationController

  before_filter :authorize_call_admin, except: [:new, :create]
  before_filter :authorize_applicant, only: [:new, :create]
  before_filter { |c| c.find_call_from_current_university :call_id }
  before_filter :find_application_from_call, except: [:index, :new, :create]

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

  protected

  def find_application_from_call
    @position_application = @call.position_applications.find(params[:id])
  end

end
