class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy)/ }

  belongs_to :organ

  field :halloped, type: Boolean, default: true
  field :position, type: Symbol
  field :current, type: Boolean, default: true
  field :term_start, type: Date
  field :term_end, type: Date
end
