module CallsHelper
  def formatted_looking_for(call)
    t('calls.show.members', :count => call.member_amount) + ", " + t("calls.show.deputies", count: call.deputy_amount)
  end

  def free_positions(call)
    call.member_amount.times.zip(call.deputy_amount.times).
      map{|member_counter, deputy_counter|
        if deputy_counter.nil?
          :position_member
        elsif member_counter.nil?
          :position_deputy
        else
          :position_both
        end
      }
  end

  def free_positions_with_selected_applicants(call)
    free_positions(call).zip(call.selected_with_deputies).map(&:flatten)
  end
end
