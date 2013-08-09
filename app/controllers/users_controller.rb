class UsersController < ApplicationController

  def edit
    @call= Call.find(params[:call_id])
  end

  def update
    @call= Call.find(params[:call_id])
    @user.update_attributes! params[:user]
    @position_application = PositionApplication.new
  end
end
