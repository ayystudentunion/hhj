class Organ
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  validates :name, allow_blank: false, presence: true

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
    organization.ancestors_and_self.drop(1).map(&:name).join(' - ')
  end

  def formatted_term
    if term_start and term_end
      I18n.l(term_start) + ' - ' + I18n.l(term_end)
    else
      ''
    end
  end

end
