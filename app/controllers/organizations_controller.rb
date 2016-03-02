
class OrganizationsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Organization.all.as_json }
    end
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
