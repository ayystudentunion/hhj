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
    member.update_attributes! member_params
    respond_to do |format|
      format.json { render :json => member }
    end
  end

  def destroy
  end

end
