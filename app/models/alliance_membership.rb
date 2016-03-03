class AllianceMembership
  include Mongoid::Document
  include Mongoid::Timestamps

  field :confirmed, type: Boolean, default: false

  belongs_to :alliance, inverse_of: :alliance_memberships, autosave: true
  belongs_to :position_application, inverse_of: :alliance_membership

  delegate :user, to: :position_application

  validates_presence_of :alliance
  validates_presence_of :position_application

  after_update :send_notifications

  def user_name
    user.full_name
  end

  def send_notifications
    AllianceMailer::Job.new.async.perform(id, nil, nil, :membership_confirmed) if confirmed_changed? && confirmed
  end
end
