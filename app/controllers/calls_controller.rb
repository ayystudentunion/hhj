class CallsController < ApplicationController
  before_action :authorize_call_admin, except: [:index, :show]
  before_action(only: [:new, :create]) { |c| c.find_organ_from_current_university :organ_id }
  before_action :find_call_from_organ_or_university, except: [:index, :new, :create, :edit_default, :update_default]

  def index
    # FIXME: Filter out somewhere else
    @calls = Call.open_by_university(@university).reject { |c| c.is_a?(DefaultCall) }
    respond_to do |format|
      format.html
      format.fragment { render 'index', formats: ['html'], layout: false }
    end
  end

  def new
    @call = @organ.default_call ? @organ.default_call.to_call : Call.new
    @form_path = organ_calls_path
    @form_title = t 'calls.new.title'
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
          flash[:errors_title] = I18n.t('shared.error_messages.title', class: call.model_name.human.downcase)
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
      format.json { render json: @call }
      format.fragment { render 'show', formats: ['html'], layout: false }
    end
  end

  def edit # form for modifing an existing call
    @form_path = call_path
    @form_title = t 'calls.edit.title'
    respond_to do |format|
      format.fragment { render 'new' }
    end
  end

  def update
    updated_call = params[:call]
    if updated_call
      @call.update_attributes!(updated_call)
      return_path = call_path(id: @call._id)
    else
      update_status(params[:status].first.first.to_sym) unless params[:status].blank?
      return_path = organ_path(id: @call.organ._id)
    end

    respond_to do |format|
      format.html do
        redirect_to return_path
      end
      format.json { render json: @call }
    end
  end

  def destroy # delete a call
  end

  def update_default
    @organ = find_organ_from_current_university :organ_id
    # FIXME: looks super sloppy
    if @organ.default_call.nil?
      @organ.default_call = DefaultCall.new
      @organ.save
    end
    @call = @organ.default_call # ? @organ.default_call : DefaultCall.new # (organ_id: @organ._id)
    @call.update_attributes!(params[:call])
    redirect_to organ_path(id: @organ._id)
  end

  def edit_default
    @organ = find_organ_from_current_university :organ_id
    @call = @organ.default_call || DefaultCall.new
    @form_path = organ_default_call_path(id: @organ._id)
    @form_title = t 'calls.edit_default.title'
    respond_to do |format|
      format.fragment { render 'new' }
    end
  end

  protected

  def find_call_from_organ_or_university
    @organ = find_organ_from_current_university :organ_id if params.include? :organ_id
    if @organ.nil?
      find_call_from_current_university
    else
      @call = @organ.calls.find(params[:id])
    end
  end

  def update_status(status)
    status = params[:status].first.first.to_sym
    if status == :handled && status != @call.status
      @call.organ.add_selected_members!(@call)
    end
    @call.status = status
    @call.save!
  end
end
