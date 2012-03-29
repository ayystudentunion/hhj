class Organ
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organization
  has_many :call

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
    organization.ancestors_and_self.map(&:name).join(' - ')
  end
end
