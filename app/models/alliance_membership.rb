class AllianceMembership
  include Mongoid::Document

  field :confirmed, type: Boolean, default: false

  belongs_to :alliance, inverse_of: :alliance_memberships, autosave: true
  belongs_to :position_application, inverse_of: :alliance_membership

  validates_presence_of :alliance
  validates_presence_of :position_application

  def user_name
    self.user.full_name
  end

  def user
    self.position_application.user
  end

end
