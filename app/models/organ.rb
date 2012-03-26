class Organ
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :organization

  field :name, localize: true
  field :description, localize: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :manager_name, type: String
  field :manager_email, type: String
  field :appointer, type: String
  field :official, type: Boolean
end
