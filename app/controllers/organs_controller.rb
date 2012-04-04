require 'factory_girl_rails'

class OrgansController < ApplicationController

  def index # list of all organs
    @organs = Organ.all

    respond_to do |format|
      format.html
      format.fragment { render "index", formats: ['html'], layout: false }
      format.json { render :json => @organs }
    end
  end

  def new # form for creating a new organ
    @organ = FactoryGirl.build(:organ)
    respond_to do |format|
      format.fragment
    end
  end

  def create # create a new organ document
    selected_organization = params[:organ][:organization].unshift(@university).reject(&:blank?).last
    organ = FactoryGirl.create(:organ, params[:organ].merge(organization: selected_organization))

    respond_to do |format|
      format.json { render json: organ.to_json }
      format.html { redirect_to action: :show, id: organ._id }
    end
  end

  def show # return a single organ
    @organ = Organ.find(params[:id])
    @open_calls = @organ.calls.asc(:date_end)
    respond_to do |format|
      format.html
      format.json { render :json => @organ }
      format.fragment { render "show", formats: ['html'], layout: false }
    end
  end

  def edit # form for modifing an existing organ
    @call = Organ.find(params[:id])
    respond_to do |format|
      format.fragment { render "new" }
    end
  end

  def update # modify an existing organ
  end

  def destroy # delete an organ
  end

end
