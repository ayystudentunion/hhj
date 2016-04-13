
class OrganizationsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Organization.all.as_json }
      format.html
    end
  end

  def new
    @organization = Organization.new
    @form_path = organizations_path
    @form_title = t 'organizationss.new.title'
    respond_to do |format|
      format.fragment
    end
  end

  def create
    @organization = selected_organization.children.build params[:organization]

    respond_to do |format|
      format.html do
        unless @organization.save
          flash[:errors_title] = I18n.t('shared.error_messages.title', class: @organization.model_name.human.downcase)
          flash[:errors] = @organization.errors.full_messages
        end
        redirect_to request.referer
      end
    end
  end

  def show
  end

  def edit
    @organization = Organization.find(params[:id])

    @form_path = organization_path
    @form_title = t 'organizations.edit.title'
    respond_to do |format|
      format.fragment { render 'new' }
    end
  end

  def update
    org_params = params[:organization].merge(parent: selected_organization)
    @organization = Organization.find(params[:id])

    @organization.update_attributes(org_params)
    redirect_to request.referer
  end

  def destroy
  end
  
  private
  def selected_organization
    Organization.find params[:organization][:parent].unshift(@university._id).reject(&:blank?).last
  end
end
