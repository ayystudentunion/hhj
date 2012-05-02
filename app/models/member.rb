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

  scope :current_hallopeds, members.where(current: true, halloped: true)
  scope :current_members, members.where(current: true)
  scope :current_deputies, deputies.where(current: true)

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
