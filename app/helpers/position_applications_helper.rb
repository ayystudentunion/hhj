module PositionApplicationsHelper

  def applicant_name_with_coapplicant_for(application)
    text = content_tag :strong, application.name
    if application.applying_for_member?
      text = text + " (#{t('position_applications.show.position_deputy.zero').downcase}: #{application.deputy.name}) " if application.deputy?
    else
      text = text + " (#{t('position_applications.show.position_member').downcase}: #{application.member.name}) " if application.member?
    end
    text
  end

end
