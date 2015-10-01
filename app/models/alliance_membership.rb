class AllianceMembership
  include Mongoid::Document
  include Mongoid::Timestamps

  field :confirmed, type: Boolean, default: false

  belongs_to :alliance, inverse_of: :alliance_memberships, autosave: true
  belongs_to :position_application, inverse_of: :alliance_membership

  validates_presence_of :alliance
  validates_presence_of :position_application

  after_update :send_notifications

  def user_name
    self.user.full_name
  end

  def user
    self.position_application.user
  end

  def send_notifications
    if confirmed_changed? && confirmed
      AllianceMailer::Job.new.async.perform(id, email: :membership_confirmed)
    end
  end
end
