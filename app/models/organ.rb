class Organ
  include Mongoid::Document

  field :name, type: String

  belongs_to :organization
end
