class Alliance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :archived, type: Boolean, default: false

  scope :active, -> { where(archived: false) }

  belongs_to :call
  belongs_to :creator, class_name: 'User', inverse_of: :alliances

  has_many :alliance_memberships, autosave: true, dependent: :destroy, inverse_of: :alliance

  validates_presence_of :creator
  validate :applications_must_belong_to_the_call

  accepts_nested_attributes_for :alliance_memberships

  def members
    alliance_memberships.map { |am| am.position_application.user }
  end

  def member_applications
    alliance_memberships.map(&:position_application)
  end

  def applications_must_belong_to_the_call
    alliance_memberships.each do |mp|
      errors.add(:call, :does_not_match_applications) unless mp.position_application.call == call
    end
  end
end
