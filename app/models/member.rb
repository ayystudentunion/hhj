class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :organ
  belongs_to :user
  belongs_to :member, :inverse_of => :deputy
  has_one :deputy, :class_name => 'Member', :inverse_of => :member

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy)/ }

  field :halloped, type: Boolean, default: true
  field :position, type: Symbol
  field :current, type: Boolean, default: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :removed_date, type: Date

  scope :current_members, where(position: :position_member, current: true)
  scope :current_deputies, where(position: :position_deputy, current: true)

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
end
