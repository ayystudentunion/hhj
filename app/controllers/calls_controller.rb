require 'factory_girl_rails'

class CallsController < ApplicationController

  before_filter :authorize_call_admin, except: [:index, :show]
  before_filter :call_belongs_to_current_university

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
    @form_path = organ_calls_path
    @form_title = t "calls.new.title"
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
    @call = Call.find(params[:id])
    @form_path = call_path
    @form_title = t "calls.edit.title"
    respond_to do |format|
      format.fragment { render "new" }
    end
  end

  def update
    call = Call.find params[:id]
    updated_call = params[:call]
    if updated_call
      call.update_attributes!(updated_call)
    else
      unless params[:status].blank?
        status = params[:status].first.first.to_sym
        if status == :handled and status != call.status
          call.organ.add_selected_members!(call)
        end
        call.status = status
      end
      call.save!
    end
    respond_to do |format|
      format.html {
        if updated_call
          redirect_to call_path(id: call._id)
        else
          redirect_to organ_path(id: call.organ._id)
        end
      }
      format.json { render :json => call }
    end
  end

  def destroy # delete an call
  end

  protected

  def call_belongs_to_current_university
    true
  end

end
