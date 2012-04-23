require 'factory_girl_rails'

class CallsController < ApplicationController

  def index
    @calls = Call.where(status: :open)
    respond_to do |format|
      format.html
      format.fragment { render "index", formats: ['html'], layout: false }
    end
  end

  def new
    organ = Organ.find params[:organ_id]
    @call  = organ.calls.build
    respond_to do |format|
      format.fragment
    end
  end

  def create # create a new call for applications
    call_params = params[:call] || {}
    call = FactoryGirl.create :call, call_params.merge(organ: Organ.find(params[:organ_id]))

    respond_to do |format|
      format.json { render json: call.to_json }
      format.html { redirect_to action: :show, id: call._id }
    end
  end

  def show # return a single call for applications
    @call = Call.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @call }
      format.fragment { render "show", formats: ['html'], layout: false }
      format.pdf { render pdf: @call.file_name, encoding: 'utf-8', layout: true }
    end
  end

  def edit # form for modifing an existing call
  end

  def update
    call = Call.find params[:id]
    call.set_results params[:selected_as]
    call.organ.add_members_from_applications params[:selected_as]
    status = params[:status]
    unless status.nil?
      call.status = status.first.first.to_sym
    end
    call.save!
    respond_to do |format|
      format.html { redirect_to organ_path(id: call.organ._id) }
      format.json { render :json => @call }
    end
  end

  def destroy # delete an call
  end

end
