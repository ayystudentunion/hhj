class AllianceMembershipsController < ApplicationController

  def update
    @alliance_membership = AllianceMembership.find(params[:id])
    @university = @alliance_membership.position_application.call.organ.organization.root

    notification = {}
    if @user && @user == @alliance_membership.position_application.user
      @alliance_membership.update_attributes!(params[:alliance_membership].slice(:confirmed))
      if @alliance_membership.confirmed?
        notification[:success] = I18n.t('alliances.confirmed_notification')
      else
        notification[:success] =I18n.t('alliances.resigned_notification')
      end
    else
      notification[:error] = "Could not proceed with the confirmation."
    end

    respond_to do |format|
      format.html do
        redirect_to university_path(university: @university.key, flash: notification)
      end
      format.js { flash.now[notification.keys.first] = notification.values.first }
    end
  end

end


