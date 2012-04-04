module CallsHelper
  def formatted_looking_for(call)
    t('calls.show.members', :count => call.member_amount) + ", " + t("calls.show.deputies", count: call.deputy_amount)
  end
end
