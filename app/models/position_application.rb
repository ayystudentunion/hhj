class PositionApplication
  include Mongoid::Document

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy|position_both)/ }
  before_save :reset_deputy_of_for_position_member

  field :position, type: Symbol
  field :deputy_of, type: String
  field :personal_statement, type: String

  belongs_to :call
  belongs_to :user

  def reset_deputy_of_for_position_member
    self.deputy_of = "" if position == :position_member
  end
end
