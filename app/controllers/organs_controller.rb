class OrgansController < ApplicationController
  before_action :authorize_organ_admin, except: [:index, :show]
  before_action :find_organ_from_current_university, except: [:index, :new, :create]

  def index # list of all organs
    @organs = Organ.visible_by_university(@university)
    respond_to do |format|
      format.html
      format.fragment { render 'index', formats: ['html'], layout: false }
      format.json { render json: @organs }
    end
  end

  def new # form for creating a new organ
    @organ = Organ.new
    @form_path = organs_path
    @form_title = t 'organs.new.title'
    respond_to do |format|
      format.fragment
    end
  end

  def create # create a new organ document
    @organ = selected_organization.organs.build params[:organ]

    respond_to do |format|
      format.html do
        if @organ.save
          redirect_to action: :show, id: @organ._id
        else
          flash[:errors_title] = I18n.t('shared.error_messages.title', class: @organ.model_name.human.downcase)
          flash[:errors] = @organ.errors.full_messages
          redirect_to request.referer
        end
      end
    end
  end

  def show # return a single organ
    @calls = @organ.calls.where(:status.in => [:open, :closed, :proposed]).asc(:date_end, :title)
    @proposals = @organ.calls.where(status: :proposed).asc(:date_end, :title)
    @handled_calls = @organ.calls.where(status: :handled).asc(:date_end, :title)
    @archived_calls = @organ.calls.where(status: :archived).asc(:date_end, :title)
    @edit_hallopeds = params.include? :edit_hallopeds
    @edit_staff = params.include? :edit_staff
    @new_member = Member.new
    respond_to do |format|
      format.html
      format.json { render json: @organ }
      format.fragment { render 'show', formats: ['html'], layout: false }
    end
  end

  def edit # form for modifing an existing organ
    @form_path = organ_path
    @form_title = t 'organs.edit.title'
    respond_to do |format|
      format.fragment { render 'new' }
    end
  end

  def update # modify an existing organ
    organ_params = params[:organ]
    organ_params = organ_params.merge(organization: selected_organization)
    respond_to do |format|
      format.html do
        if @organ.update_attributes(organ_params)
          redirect_to action: :show, id: @organ._id
        else
          flash[:errors_title] = I18n.t('shared.error_messages.title', class: @organ.model_name.human.downcase)
          flash[:errors] = @organ.errors.full_messages
          redirect_to request.referer
        end
      end
    end
  end

  def destroy # delete an organ
  end

  protected

  def selected_organization
    Organization.find params[:organ][:organization].unshift(@university._id).reject(&:blank?).last
  end
end
