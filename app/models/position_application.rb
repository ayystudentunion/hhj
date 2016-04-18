class PositionApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position
  include Models::AppliedPosition

  belongs_to :call
  belongs_to :user, inverse_of: :position_applications

  has_many :recommendations
  has_many :alliance_memberships, inverse_of: :position_application, dependent: :destroy

  validate :validate_member_and_deputy_positions
  validate :degree_present_for_administrational_call
  before_save :reset_deputy_of_for_position_member
  before_save :reset_member_for_position_member

  field :position, type: Symbol
  position_field :selected_as
  applied_position_field :position
  field :deputy_of, type: String
  field :personal_statement, type: String
  field :custom, type: Hash

  after_create :send_confirmation_email

  def reset_deputy_of_for_position_member
    self.deputy_of = '' if applying_for_member?
  end

  def reset_member_for_position_member
    self.member = nil if applying_for_member? && selected_as.nil?
  end

  def degree_present_for_administrational_call
    errors[:base] << I18n.translate('mongoid.errors.models.position_application.degree_must_be_present') if call.university.try(:key) == 'helsinki' &&
                                                                                                            call.administrational? &&
                                                                                                            (custom.nil? || custom['degree'].blank?)
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
    Recommendation.find_by(user_id: user._id, position_application_id: _id)
  end

  def admissible?
    recommendations_for_pair.count >= call.recommendations_threshold
  end

  def pair
    if position == :position_deputy
      member
    else
      deputy
    end
  end

  # recommendations are given to a pair. The implementation is that you can only recommend the primary application,
  # and these recommendations are considered to belong to the deputy as well
  def recommendations_for_pair
    if position == :position_deputy && member
      member.recommendations
    else
      recommendations
    end
  end

  def applying_for_member?
    position == :position_member
  end

  def send_confirmation_email
    if call && call.administrational?
      ApplicationMailer:: AdminstrationalApplicationConfirmationJob.new.async.perform(id, I18n.locale)
    else
      ApplicationMailer::ApplicationConfirmationJob.new.async.perform(id)
    end
  end
end
