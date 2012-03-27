require 'factory_girl_rails'

class OrgansController < ApplicationController

  def index # list of all organs
    @organs = Organ.all

    respond_to do |format|
      format.html
      format.fragment { render "index.html", layout: false, locals: { organs: @organs } }
      format.json { render :json => @organs }
    end
  end

  def new # form for creating a new organ
    @organ = Factory.build(:organ)
    respond_to do |format|
      format.html { render "pages/index" }
    end
  end

  def create # create a new organ document
    organ = Factory(:organ, params[:organ])

    respond_to do |format|
      format.json { render json: organ.to_json }
      format.html { redirect_to action: :show, id: organ._id }
    end
  end

  def show # return a single organ
    @organ = Organ.find(params[:id])
    respond_to do |format|
      format.html
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
