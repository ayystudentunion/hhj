class AllianceMembershipsController < ApplicationController

  def confirm
    @alliance_membership = AllianceMembership.find(params[:alliance_membership_id])
    @university = @alliance_membership.position_application.call.organ.organization.root

    notification = {}
    if @user && @user == @alliance_membership.position_application.user
      @alliance_membership.update_attributes(confirmed: true)
      notification[:success] = I18n.t('alliances.confirmed_notification')
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


