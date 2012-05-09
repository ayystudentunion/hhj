class PositionApplicationsController < ApplicationController

  before_filter :authorize_call_admin, except: [:index, :show, :new, :create]
  before_filter :find_application_from_current_university, except: [:index, :new, :create]

  def index
  end

  def show
    respond_to do |format|
      format.fragment
    end
  end

  def new
    find_call_from_current_university :call_id
    @position_application = @call.position_applications.build(user_id: @user._id)

    respond_to do |format|
      format.fragment
    end
  end

  def edit
  end

  def create
    @position_application = find_call_from_current_university(:call_id).position_applications.create! params[:position_application]
  end

  def update
    position_params = params[:position_application]
    @position_application.update_attributes! position_params
    respond_to do |format|
      format.json { render :json => @position_application }
    end
  end

  def destroy
  end

  protected

  def find_application_from_current_university
    @position_application = PositionApplication.find(params[:id])
    verify_university @position_application.call.organ.organization
  end

end
