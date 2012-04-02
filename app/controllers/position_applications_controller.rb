class PositionApplicationsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @position_application = PositionApplication.new

    respond_to do |format|
      format.fragment
    end
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
