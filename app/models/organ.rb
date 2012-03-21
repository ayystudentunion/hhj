class Organ
  include Mongoid::Document

  field :name, localize: true
  field :description, localize: true
  field :term_start, type: Date
  field :term_end, type: Date
  field :owner, type: String # TODO: ref to Person

  belongs_to :organization
end
