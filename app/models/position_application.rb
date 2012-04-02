class PositionApplication
  include Mongoid::Document

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy|position_both)/ }

  field :position, type: Symbol
  field :deputy_of, type: String
  field :personal_statement, type: String

  belongs_to :call
  belongs_to :user

end
