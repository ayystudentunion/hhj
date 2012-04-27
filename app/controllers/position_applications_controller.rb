class PositionApplicationsController < ApplicationController

  before_filter :authorize_call_admin, except: [:index, :show]

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
    position_application = PositionApplication.find params[:id]
    position_application_params = params[:position_application]

    if position_application_params[:position] == :position_member.to_s
      position_application.mark_as_member! position_application_params[:deputy]
    elsif position_application_params[:position] == :position_deputy.to_s
      position_application.mark_as_deputy! position_application_params[:member]
    else
      position_application.mark_as_not_selected!
    end
    respond_to do |format|
      format.json { render :json => position_application }
    end
  end

  def destroy
  end

end
