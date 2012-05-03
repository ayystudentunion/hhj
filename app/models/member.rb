class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position

  belongs_to :organ
  belongs_to :user

  before_save :add_removed_date_if_resigned

  field :halloped, type: Boolean, default: true
  field :current, type: Boolean, default: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :removed_date, type: Date
  position_field :position

  scope :currents, where(current: true)
  scope :hallopeds, where(halloped: true)
  scope :current_hallopeds, currents.hallopeds
  scope :current_members, current_hallopeds.members
  scope :current_deputies, current_hallopeds.deputies
  scope :staff, where(halloped: false)
  scope :current_staff, currents.staff

  def current_deputy
    return nil if deputy.nil?
    return nil unless deputy.current
    deputy
  end

  def current_member
    return nil if member.nil?
    return nil unless member.current
    member
  end

  protected

  def add_removed_date_if_resigned
    if current_changed? and not current
      self.removed_date = Time.now.utc
    end
  end

end
