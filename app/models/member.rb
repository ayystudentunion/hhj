class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy)/ }

  belongs_to :organ
  belongs_to :user

  field :halloped, type: Boolean, default: true
  field :position, type: Symbol
  field :current, type: Boolean, default: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :removed_date, type: Date

end
