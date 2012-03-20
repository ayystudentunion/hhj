class Organization
  include Mongoid::Document

  field :name, type: String

  has_many    :organs
  has_many    :children, class_name: "Organization"
  belongs_to  :parent, class_name: "Organization"
end
