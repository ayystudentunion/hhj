class EligibilityRule
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :eligibility_rule_sets

  field :name, localize: true
  field :edu_field, type: String
  field :valid_values, type: Array

  def valid_value?(value)
    return true if valid_values.empty?
    valid_values.include? value
  end

  def match?(position_application)
    return false if position_application.nil?
    return false if position_application.user.edu_data.nil?
    return false unless position_application.user.edu_data.include? edu_field
    valid_value? position_application.user.edu_data[edu_field]
  end
end
