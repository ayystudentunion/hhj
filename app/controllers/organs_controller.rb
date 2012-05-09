require 'factory_girl_rails'

class OrgansController < ApplicationController

  before_filter :authorize_organ_admin, except: [:index, :show]

  def index # list of all organs
    @organs = Organ.by_university(@university)
    respond_to do |format|
      format.html
      format.fragment { render "index", formats: ['html'], layout: false }
      format.json { render :json => @organs }
    end
  end

  def new # form for creating a new organ
    @organ = Organ.new #FactoryGirl.build(:organ)
    @form_path = organs_path
    @form_title = t 'organs.new.title'
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
    @calls = @organ.calls.where(:status.in => [:open, :closed, :proposed]).asc(:date_end, :title)
    @proposals = @organ.calls.where(status: :proposed).asc(:date_end, :title)
    @handled_calls = @organ.calls.where(status: :handled).asc(:date_end, :title)
    @archived_calls = @organ.calls.where(status: :archived).asc(:date_end, :title)
    @edit_hallopeds = params.include? :edit_hallopeds
    @edit_staff = params.include? :edit_staff
    @new_member = Member.new
    respond_to do |format|
      format.html
      format.json { render :json => @organ }
      format.fragment { render "show", formats: ['html'], layout: false }
    end
  end

  def edit # form for modifing an existing organ
    @organ = Organ.find(params[:id])
    @form_path = organ_path
    @form_title = t 'organs.edit.title'
    respond_to do |format|
      format.fragment { render "new" }
    end
  end

  def update # modify an existing organ
    organ = Organ.find(params[:id])
    organ_params = params[:organ]
    selected_organization = organ_params[:organization].unshift(@university).reject(&:blank?).last
    organ_params = organ_params.merge(organization: selected_organization)
    organ.update_attributes!(organ_params)
    respond_to do |format|
      format.html { redirect_to action: :show, id: organ._id }
    end
  end

  def destroy # delete an organ
  end

end
