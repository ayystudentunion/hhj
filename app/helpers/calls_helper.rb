module CallsHelper
  def formatted_looking_for(call)
    t('calls.show.members', :count => call.member_amount) + ", " + t("calls.show.deputies", count: call.deputy_amount)
  end

  def has_deputy_array(call)
    call.member_amount.times.zip(call.deputy_amount.times).map{|pair| not pair.last.nil?}
  end
end
