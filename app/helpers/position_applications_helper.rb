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

  def rearrange_pairs_adjancently(position_applications)
    with_member = position_applications.partition{|application| application.member_id != nil}[0]
    pairs = with_member.map do|deputy|
      member= position_applications.select{|application| application.id == deputy.member_id }
      [member, deputy]
    end
    pairs.delete_if {|application| application == nil}.flatten | position_applications # | operation will append applications with no pair to the list

  end

end
