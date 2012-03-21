class OrgansController < ApplicationController

  def index # list of all organs
    respond_to do |format|

      @organs = Organ.all

      format.html
      format.fragment { render :partial => "organs", :locals => { :organs => @organs } }
      format.json { render :json => @organs }
    end
  end

  def new # form for creating a new organ
    respond_to do |format|
      format.html { render "pages/index" }
    end
  end

  def create # create a new organ document
  end

  def show # return a single organ
    respond_to do |format|
      format.html { render "pages/index" }
      format.json { render :json => Organ.find(params[:id]) }
    end
  end

  def edit # form for modifing an existing organ
    respond_to do |format|
      format.html { render "pages/index" }
    end
  end

  def update # modify an existing organ
  end

  def destroy # delete an organ
  end

end
