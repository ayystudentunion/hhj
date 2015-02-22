class EligibilityRuleSet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :organization
  has_and_belongs_to_many :eligibility_rules
  has_many :calls

  field :name, localize: true

  def match?(position_application)
    eligibility_rules.all?{|rule| rule.match? position_application }
  end
end
