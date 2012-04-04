class Organ
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  validates :name, :organization, :official, allow_blank: false, presence: true

  belongs_to :organization
  has_many :calls
  has_many :members

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

  def add_members_from_applications(position_results)
    return if position_results.nil? or position_results.empty?

    position_results.select{ |position, ids|
      [:position_member, :position_deputy].include? position.to_sym
    }.each do | position, ids|
      ids.each do |id|
        self.members << Member.create(user: PositionApplication.find(id).user, position: position)
      end
    end
  end

end
