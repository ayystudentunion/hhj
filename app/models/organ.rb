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
    call.position_applications.where(:selected_as.ne => nil).each do | position_application |
      self.members << Member.create!(
        user: position_application.user,
        position: position_application.selected_as,
        term_start: position_application.call.term_start,
        term_end: position_application.call.term_end
      )
    end
  end

  def resign_member(id)
    return if id.nil?
    members.where(_id: id).update_all(current: false, resigned_date: Time.now.utc)
  end

end

