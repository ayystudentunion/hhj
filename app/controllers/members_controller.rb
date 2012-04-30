class MembersController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    member = Member.find params[:id]
    member_params = params[:member]
    member.set_position! member_params
    current = member_params[:current]
    if member.current and current == 'false'
      member_params.merge!(removed_date: Time.now.utc)
    end
    member.update_attributes! member_params

    respond_to do |format|
      format.json { render :json => member }
    end
  end

  def destroy
  end

end
