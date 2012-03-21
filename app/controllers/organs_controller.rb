class OrgansController < ApplicationController

  def index # list of all organs
    respond_to do |fmt|
      fmt.html { render "pages/index" }
      fmt.json { render :json => Organ.all }
    end
  end

  def new # form for creating a new organ
    respond_to do |fmt|
      fmt.html { render "pages/index" }
    end
  end

  def create # create a new organ document
  end

  def show # return a single organ
    respond_to do |fmt|
      fmt.html { render "pages/index" }
      fmt.json { render :json => Organ.find(params[:id]) }
    end
  end

  def edit # form for modifing an existing organ
    respond_to do |fmt|
      fmt.html { render "pages/index" }
    end
  end

  def update # modify an existing organ
  end

  def destroy # delete an organ
  end

end
