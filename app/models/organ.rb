class Organ
  include Mongoid::Document

  field :name, localize: true

  belongs_to :organization
end
