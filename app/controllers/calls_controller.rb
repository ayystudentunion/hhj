class CallsController < ApplicationController

  def index
  end

  def new
    organ = Organ.find params[:organ_id]
    call  = CallForApplications.new
    respond_to do |format|
      format.fragment { render partial: "modals/call-for-application.html", locals: {organ: organ, call: call} }
    end
  end

  def create # create a new organ document

    organ = Factory(:call, params[:call_for_applications])

    respond_to do |format|
      format.json { render json: organ.to_json }
      format.html { redirect_to action: :show, id: organ._id }
    end
  end

  def show # return a single organ
    @call = CallForApplications.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @call }
      format.fragment { render "show", formats: ['html'], layout: false }
    end
  end

  def edit # form for modifing an existing organ
  end

  def update # modify an existing organ
  end

  def destroy # delete an organ
  end

end
