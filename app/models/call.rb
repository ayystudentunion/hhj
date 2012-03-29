class Call
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organ

  field :date_open, type: Date
  field :date_start, type: Date
  field :date_end, type: Date

  field :term_start, type: Date
  field :term_end, type: Date

end
