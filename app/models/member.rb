class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Position

  GROUPS = [:group_hallopeds, :group_staff, :group_professors]
  belongs_to :organ
  belongs_to :user

  before_save :add_removed_date_if_resigned

  validates :group, allow_blank: false, presence: true, inclusion: { in: GROUPS }

  field :group, type: Symbol, default: :group_hallopeds
  field :current, type: Boolean, default: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :removed_date, type: Date
  position_field :position

  scope :currents,  -> { where(current: true) }
  scope :hallopeds, -> {  where(group: :group_hallopeds) }
  scope :current_hallopeds, -> {  currents.hallopeds }
  scope :current_members, -> {  current_hallopeds.members }
  scope :current_deputies, -> {  current_hallopeds.deputies }
  scope :staff, -> {  where(group: :group_staff) }
  scope :current_staff, -> {  currents.staff }
  scope :professors, -> {  where(group: :group_professors) }
  scope :current_professors, -> {  currents.professors }

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
