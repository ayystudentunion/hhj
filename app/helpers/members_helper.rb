module MembersHelper
  def formatted_terms(member)
    same_members = member.organ.members.where(user_id: member.user._id).asc(:term_end)
    same_members.map{|member|
      term = formatted_date member.term_start, end_date:member.term_end
      term = t 'organs.member.open_ended' if term.blank?
      term
    }.join(', ')
  end
end
