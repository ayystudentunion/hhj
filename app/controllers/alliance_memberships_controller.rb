class AllianceMembershipsController < ApplicationController
  def update
    @alliance_membership = AllianceMembership.find(params[:id])
    @university = @alliance_membership.position_application.call.organ.organization.root

    if @alliance_membership.user == @user
      @alliance_membership.update_attributes!(params[:alliance_membership].slice(:confirmed))
      flash.now[:success] = if @alliance_membership.confirmed?
                              I18n.t('alliances.confirmed_notification')
                            else
                              I18n.t('alliances.resigned_notification')
                            end
    end
  end
end
