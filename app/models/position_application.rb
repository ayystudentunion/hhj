class PositionApplication
  include Mongoid::Document
  include Mongoid::Timestamps

  SELECTED_AS_VALUES = [:position_member, :position_deputy]

  validates :position, presence: true, :format => { :with => /(position_member|position_deputy|position_both)/ }
  validates :selected_as, allow_nil: true, inclusion: { in:  SELECTED_AS_VALUES }
  validate :validate_member_and_deputy_positions
  before_save :reset_deputy_of_for_position_member

  field :position, type: Symbol
  field :selected_as, type: Symbol
  field :deputy_of, type: String
  field :personal_statement, type: String

  belongs_to :call
  belongs_to :user

  belongs_to :member, :class_name => 'PositionApplication', :inverse_of => :deputy
  has_one :deputy, :class_name => 'PositionApplication', :inverse_of => :member

  def reset_deputy_of_for_position_member
    self.deputy_of = "" if position == :position_member
  end

  def eligible?
    return call.eligibility_rule_sets.all?{rule.match?(self)}
  end

  def nil_or_find(id)
    id.blank? ? nil : PositionApplication.find(id)
  end

  def with_deputy_and_member_relations_cleared(id)
    position_application = nil_or_find(id)
    unless position_application.nil?
      position_application.deputy = nil
      position_application.member = nil
      position_application.save!
    end
    position_application
  end

  def mark_as_member!(deputy_id)
    self.selected_as = :position_member
    self.member = nil
    self.deputy = with_deputy_and_member_relations_cleared(deputy_id)
    save!
  end

  def mark_as_deputy!(member_id)
    self.selected_as = :position_deputy
    self.deputy = nil
    self.member = with_deputy_and_member_relations_cleared(member_id)
    save!
  end

  def mark_as_not_selected!
    self.selected_as = nil
    self.member = nil
    self.deputy = nil
    save!
  end

  def validate_member_and_deputy_positions
    def validate(relation, allowed_position)
      other = send(relation)
      return if other.nil?
      if other.selected_as != allowed_position
        errors.add(
            relation, errors.generate_message(
              relation, :position))
      end
    end
    validate :deputy, :position_deputy
    validate :member, :position_member
  end

end
