module PositionApplicationsHelper

  def applicant_name_with_coapplicant_for(application, show_modal_link = true)
    translated_position = translated_position(application.position)

    text = show_modal_link ? modal_link_to(application) : application.name
    text = content_tag(:strong, text) + " (" + translated_position.downcase
    if application.deputy?
      text = text + ", #{translated_position('position_deputy')}: #{application.deputy.try(:name)}"
    elsif application.member?
      text = text + ", #{}: #{application.member.try(:name)}"
    end
    text + ")"
  end

  def print_with_coapplicant(deputy)
    member_text = "#{deputy.member.try(:name)} (#{translated_position('position_member')}) "
    deputy_text = " #{deputy.name} (#{translated_position('position_deputy')})"
    member_text + t("particles.and") + deputy_text
  end

  def translated_position(position)
    t("position_applications.show.#{position.to_s}.zero").downcase
  end

  def rearrange_pairs_adjacently(position_applications)
    with_member = position_applications.partition{|application| application.member_id != nil}[0]
    pairs = with_member.map do|deputy|
      member= position_applications.select{|application| application.id == deputy.member_id }
      [member, deputy]
    end
    pairs.delete_if {|application| application == nil}.flatten | position_applications # | operation will append applications with no pair to the list
  end

  def modal_link_to(application)
    link_to(application.user.full_name, call_position_application_path(call_id: application.call._id, id:application._id), class: "name js-modal show-application")
  end

end
