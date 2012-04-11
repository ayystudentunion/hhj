class PositionApplicationsController < ApplicationController

  def index
  end

  def show
    @position_application = PositionApplication.find(params[:id])
    respond_to do |format|
      format.fragment
    end
  end

  def new
    call = Call.find params[:call_id]
    @position_application = call.position_applications.build(user_id: @user._id)

    respond_to do |format|
      format.fragment
    end
  end

  def edit
  end

  def create
    position_application_params = params[:position_application] || {}
    call = Call.find params[:call_id]
    @position_application = FactoryGirl.create :position_application,
      position_application_params.merge(call: call)
  end

  def update
  end

  def destroy
  end

end
