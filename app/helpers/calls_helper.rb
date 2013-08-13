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
    free_positions(call).zip(
      sort_by_free_positions(call.selected_with_deputies, call)).
        map(&:flatten)
  end

  def workflow_values_with_names
    Call::WORKFLOW_VALUES.map{|v| [Call.human_attribute_name(v), v]}
  end

  def eligibility_rule_sets_with_names
    @university.eligibility_rule_sets.map{|r| [r.name, r._id] }
  end

  def show_recommendations?
     @user && @user.university.recommendations_threshold.present? && @call.administrational?
  end

  protected

  # Needed to make sure that lone deputies are always rendered visible.
  # Example: If there are 2 member positions and 1 deputy and user adds one
  # deputy without member and one member without deputy. Then we need to order
  # the lone deputy before lone member, otherwise there would not be a place for it in view
  def sort_by_free_positions(selected_applicants, call)
    more_members_than_deputies = call.member_amount > call.deputy_amount
    selected_applicants.sort_by{|m,d|
      if (not m.nil?) and (not d.nil?)
        0
      elsif more_members_than_deputies
        m.nil? ? 1 : 2
      else
        m.nil? ? 2 : 1
      end
    }
  end
end
