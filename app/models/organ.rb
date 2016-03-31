class Organ
  include Mongoid::Document
  include Ext::Mongoid::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organization
  has_many :calls, dependent: :delete
  has_many :members, dependent: :nullify

  validates :name, :organization, presence: { allow_blank: false }
  validates :official, inclusion: { in: [true, false] }

  field :name, localize: true
  field :description, localize: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :manager_name, type: String
  field :manager_email, type: String
  field :appointer, type: String
  field :official, type: Boolean
  field :status, type: Symbol, default: :visible

  scope :visible, -> { where(status: :visible) }

  def self.visible_by_university(university)
    visible.select { |o| o.belongs_to?(university) }
  end

  def self.by_university(university)
    all.select { |o| o.belongs_to?(university) }
  end

  def belongs_to?(university)
    organization._id == university._id || organization.descendant_of?(university)
  end

  def unofficial
    !official
  end

  # FIXME: naming
  def organization_full_name
    organization.ancestors_and_self.drop(1).map(&:name)
  end

  def organization_ids
    return [] unless organization
    organization.ancestors_and_self.drop(1).map(&:_id)
  end

  def add_selected_members!(call)
    call.selected_with_deputies.each do |member, deputy|
      member = member.nil? ? nil : Member.create!(
        user: member.user,
        position: :position_member,
        term_start: call.term_start,
        term_end: call.term_end
      )
      deputy = deputy.nil? ? nil : Member.create!(
        user: deputy.user,
        position: :position_deputy,
        member: member,
        term_start: call.term_start,
        term_end: call.term_end
      )
      members << [member, deputy].reject(&:blank?)
    end
  end

  def member_deputy_pairs
    members_with_deputies = members.current_members.map { |a| [a, a.current_deputy] }.sort_by { |_m, d| d.nil? ? 1 : 0 }
    lone_deputies = members.current_deputies.lone_deputies.map { |a| [nil, a] }
    members_with_deputies + lone_deputies
  end
end
