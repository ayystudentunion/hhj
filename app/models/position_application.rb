class PositionApplication
  include Mongoid::Document
  include Mongoid::Timestamps

  SELECTED_AS_VALUES = [:position_member, :position_deputy, :position_rejected]

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy|position_both)/ }
  validates :selected_as, allow_nil: true, inclusion: { in:  SELECTED_AS_VALUES }
  before_save :reset_deputy_of_for_position_member

  field :position, type: Symbol
  field :selected_as, type: Symbol
  field :deputy_of, type: String
  field :personal_statement, type: String

  belongs_to :call
  belongs_to :user

  def reset_deputy_of_for_position_member
    self.deputy_of = "" if position == :position_member
  end
end
