class PositionApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position

  belongs_to :call
  belongs_to :user, inverse_of: :position_applications

  has_many :recommendations
  has_many :alliance_memberships, inverse_of: :position_application

  validates :position, presence: true, inclusion: { in: POSITION_VALUES + [:position_both]}
  validate :validate_member_and_deputy_positions
  before_save :reset_deputy_of_for_position_member
  before_save :reset_member_for_position_member

  field :position, type: Symbol
  position_field :selected_as
  field :deputy_of, type: String
  field :personal_statement, type: String
  field :custom, type: Hash
  scope :recommendable, where(selected_as:nil, position: :position_member)

  def reset_deputy_of_for_position_member
    self.deputy_of = "" if position == :position_member
  end

  def reset_member_for_position_member
    self.member = nil if position == :position_member && selected_as == nil
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
    self.recommendations_for_pair.count >= call.recommendations_threshold
  end

  def alliance
    self.alliance_membership.alliance
  end

  #recommendations are given to a pair. The implementation is that you can only recommend the primary application,
  #and these recommendations are considered to belong to the deputy as well
  def recommendations_for_pair
    if self.position == :position_deputy && self.member
      self.member.recommendations
    else
      self.recommendations
    end
  end

end
