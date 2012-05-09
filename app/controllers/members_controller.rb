class MembersController < ApplicationController

  before_filter :find_member_from_current_university, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    find_organ_from_current_university :organ_id
    member_params = params[:member]
    user = User.find_or_create_by(email: member_params[:email])
    user.save!
    @member = Member.create! member_params.merge(user: user, organ: @organ)
    respond_to do |format|
      format.html { render partial: 'organs/member', locals: {edit: true, member: @member, member_counter: 0} }
    end
  end

  def update
    member_params = params[:member]
    @member.update_attributes! member_params
    respond_to do |format|
      format.json { render :json => @member }
    end
  end

  def destroy
  end

  protected

  def find_member_from_current_university
    @member = Member.find(params[:id])
    verify_university @member.organ.organization
  end
end
