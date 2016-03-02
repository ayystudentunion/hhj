class UsersController < ApplicationController
  def edit
    @call = Call.find(params[:call_id])
    respond_to do |format|
      format.fragment
    end
  end

  def update
    @call = Call.find(params[:call_id])
    @user.update_attributes! params[:user].slice(:phone)
    @position_application = PositionApplication.new
  end
end
