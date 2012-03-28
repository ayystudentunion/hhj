class Call
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organ
end
