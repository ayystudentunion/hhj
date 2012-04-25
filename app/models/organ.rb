class Organ
  include Mongoid::Document
  include Ext::Mongoid::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organization
  has_many :calls
  has_many :members

  validates :name, :organization, :official, allow_blank: false, presence: true

  field :name, localize: true
  field :description, localize: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :manager_name, type: String
  field :manager_email, type: String
  field :appointer, type: String
  field :official, type: Boolean

  def unofficial
    not official
  end

  def organization_full_name
    organization.ancestors_and_self.drop(1).map(&:name).join(' - ')
  end

  def organization_ids
    return "" if not organization
    organization.ancestors_and_self.drop(1).map(&:_id).join('|')
  end

  def add_selected_members!(call)
    call.selected_with_deputies.each do | member, deputy |
      member = member.nil? ? nil : Member.create!(
        user: member.user,
        position: member.selected_as,
        term_start: call.term_start,
        term_end: call.term_end
      )
      deputy = deputy.nil? ? nil : Member.create!(
        user: deputy.user,
        position: deputy.selected_as,
        member: member,
        term_start: call.term_start,
        term_end: call.term_end
      )
      self.members << [member, deputy].reject(&:blank)
    end
  end

  def resign_member(id)
    return if id.nil?
    members.where(_id: id).update_all(current: false, resigned_date: Time.now.utc)
  end

end

