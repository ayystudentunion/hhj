class Call
  include Mongoid::Document
  include Ext::Mongoid::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organ
  has_many :position_applications
  has_and_belongs_to_many :eligibility_rule_sets

  validates :title, :member_amount, :deputy_amount, allow_blank: false, presence: true
  validates :status, presence: true, allow_blank: false, :format => { :with => /(open|closed|handled|archived)/ }

  field :title, localize: true
  field :status, type: Symbol, default: :open
  field :member_amount, type: Integer, default: 0
  field :deputy_amount, type: Integer, default: 0
  field :quota_information, localize: true
  field :date_open, type: Date
  field :date_start, type: Date
  field :date_end, type: Date
  field :term_start, type: Date
  field :term_end, type: Date
  field :appointment_place_and_date, localize: true
  field :description, localize: true

  def has_unhandled_applications
    position_applications.where(selected_as: nil).exists?
  end

  def file_name
    ::Sanitizer.sanitize_filename(title + '_' + I18n.l(updated_at, format: :file))
  end

  def selected_with_deputies
    members = position_applications.
      where(selected_as: :position_member).
        map{|a| [a, a.deputy]}

    lone_deputies = position_applications.
      where(selected_as: :position_deputy, member_id: nil).
        map{|a| [nil, a]}

    members + lone_deputies
  end

end
