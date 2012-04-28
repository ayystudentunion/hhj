class PositionApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position
  SELECTED_AS_VALUES = [:position_member, :position_deputy]

  belongs_to :call
  belongs_to :user
  belongs_to :member, :class_name => 'PositionApplication', :inverse_of => :deputy
  has_one :deputy, :class_name => 'PositionApplication', :inverse_of => :member

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy|position_both)/ }
  validates :selected_as, allow_nil: true, inclusion: { in:  SELECTED_AS_VALUES }
  validate :validate_member_and_deputy_positions
  before_save :reset_deputy_of_for_position_member

  field :position, type: Symbol
  field :selected_as, type: Symbol
  field :deputy_of, type: String
  field :personal_statement, type: String

  def reset_deputy_of_for_position_member
    self.deputy_of = "" if position == :position_member
  end

  def eligible?
    return call.eligibility_rule_sets.all?{rule.match?(self)}
  end

  def nil_or_find(id)
    id.blank? ? nil : PositionApplication.find(id)
  end



end
