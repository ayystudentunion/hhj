class PositionApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position

  belongs_to :call
  belongs_to :user

  has_many :recommendations
  belongs_to :alliance

  validates :position, presence: true, inclusion: { in: POSITION_VALUES + [:position_both]}
  validate :validate_member_and_deputy_positions
  before_save :reset_deputy_of_for_position_member

  field :position, type: Symbol
  position_field :selected_as
  field :deputy_of, type: String
  field :personal_statement, type: String
  field :custom, type: Hash
  field :alliance_confirmed, type: Boolean, default: false

  def reset_deputy_of_for_position_member
    self.deputy_of = "" if position == :position_member
  end

  def eligible?
    rule_set = call.eligibility_rule_set
    return true if rule_set.nil?
    rule_set.match? self
  end

  def name
    user.full_name
  end

  def deputy_of_safe_length
    deputy_of.nil? ? 0 : deputy_of.length
  end

  def recommendation_by(user)
    Recommendation.where(user_id: user._id, position_application_id: self._id).first
  end

  def admissible?
    self.recommendations.count >= call.recommendations_threshold
  end
end
