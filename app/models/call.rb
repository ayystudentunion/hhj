class Call
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  validates :title, :member_amount, :deputy_amount, allow_blank: false, presence: true

  belongs_to :organ

  field :title, localize: true
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

end
