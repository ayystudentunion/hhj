class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position

  belongs_to :organ
  belongs_to :user

  field :halloped, type: Boolean, default: true
  field :current, type: Boolean, default: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :removed_date, type: Date
  position_field :position

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
