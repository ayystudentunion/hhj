
class OrganizationsController < ApplicationController

  def index
    respond_to do |format|
      format.json { render :json => Organization.roots.map(&:tree_hash).as_json }
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
