class EligibilityRule
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :eligibility_rule_set

  field :edu_field, type: String
  field :valid_values, type: Array

  def valid_value?(value)
    return true if valid_values.empty?
    valid_values.include? value
  end

  def match(position_application)
    return false if position_application.nil?
    return false if position_application.user.edu_data.nil?
    valid_value? position_application.user.edu_data[edu_field]
  end
end
