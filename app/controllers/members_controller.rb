class MembersController < ApplicationController

  before_filter :authorize_organ_admin
  before_filter { |c| c.find_organ_from_current_university :organ_id }
  before_filter :find_member_from_organ, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    member_params = params[:member]
    user = @university.users.find_or_create_by(email: member_params[:email])
    user.save!
    @member = @organ.members.create! member_params.merge(user: user)
    respond_to do |format|
      format.html { render partial: 'organs/member', locals: {edit: true, member: @member, member_counter: 0} }
    end
  end

  def update
    @member.update_attributes! params[:member]
    respond_to do |format|
      format.json { render :json => @member }
    end
  end

  def destroy
  end

  protected

  def find_member_from_organ
    @member = @organ.members.find params[:id]
  end
end
