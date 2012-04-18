class EligibilityRuleSet
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :eligibility_rules
  has_and_belongs_to_many :calls

  def match?(position_application)
    eligibility_rules.all?{|rule| rule.match? position_application }
  end
end
