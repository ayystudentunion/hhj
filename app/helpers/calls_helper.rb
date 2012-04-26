module CallsHelper
  def formatted_looking_for(call)
    t('calls.show.members', :count => call.member_amount) + ", " + t("calls.show.deputies", count: call.deputy_amount)
  end

  def free_positions(call)
    [call.member_amount, call.deputy_amount].max.times.
      map{|index|
        if index >= call.deputy_amount
          :position_member
        elsif index >= call.member_amount
          :position_deputy
        else
          :position_both
        end
      }
  end

  def free_positions_with_selected_applicants(call)
    free_positions(call).zip(call.selected_with_deputies).map(&:flatten)
  end

  def workflow_values_with_names
    Call::WORKFLOW_VALUES.map{|v| [Call.human_attribute_name(v), v]}
  end
end
