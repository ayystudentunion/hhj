require 'factory_girl_rails'

class CallsController < ApplicationController

  before_filter :authorize_call_admin, except: [:index, :show]
  before_filter(only: [:new, :create]) { |c| c.find_organ_from_current_university :organ_id }
  before_filter :find_call_from_organ_or_university, except: [:index, :new, :create]

  def index
    @calls = Call.open_by_university @university
    respond_to do |format|
      format.html
      format.fragment { render "index", formats: ['html'], layout: false }
      format.pdf do
        #quickfix before different scopes are properly supported in this action:
        @calls = Call.by_university @university
        render pdf: "calls", encoding: 'utf-8', layout: true
      end
    end
  end

  def new
    @call = @organ.calls.build
    @form_path = organ_calls_path
    @form_title = t "calls.new.title"
    respond_to do |format|
      format.fragment
    end
  end

  def create # create a new call for applications
    call = @organ.calls.new params[:call]

    respond_to do |format|
      format.json { render json: call.to_json }
      format.html do
        if call.save
          redirect_to action: :show, id: call._id
        else
          flash[:errors_title]= I18n.t('shared.error_messages.title', class: call.model_name.human.downcase)
          flash[:errors] = call.errors.full_messages
          redirect_to organ_path(id: @organ._id)
        end
      end
    end
  end

  def show # return a single call for applications
    @position_applications = @call.position_applications
    respond_to do |format|
      format.html
      format.json { render :json => @call }
      format.fragment { render "show", formats: ['html'], layout: false }
      format.pdf { render pdf: @call.file_name, encoding: 'utf-8', layout: true }
      format.print { render "show", formats: ['pdf'], encoding: 'utf-8' }
    end
  end

  def edit # form for modifing an existing call
    @form_path = call_path
    @form_title = t "calls.edit.title"
    respond_to do |format|
      format.fragment { render "new" }
    end
  end

  def update
    updated_call = params[:call]
    if updated_call
      @call.update_attributes!(updated_call)
    else
      unless params[:status].blank?
        status = params[:status].first.first.to_sym
        if status == :handled and status != @call.status
          @call.organ.add_selected_members!(@call)
        end
        @call.status = status
      end
      @call.save!
    end

    respond_to do |format|
      format.html {
        if updated_call
          redirect_to call_path(id: @call._id)
        else
          redirect_to organ_path(id: @call.organ._id)
        end
      }
      format.json { render :json => @call }
    end
  end

  def destroy # delete a call
  end

  protected

  def find_call_from_organ_or_university
    @organ = find_organ_from_current_university :organ_id if params.include? :organ_id
    unless @organ.nil?
      @call = @organ.calls.find(params[:id])
    else
      find_call_from_current_university
    end
  end

end
