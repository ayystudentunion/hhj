class Organization
  include Mongoid::Document

  belongs_to  :parent, class_name: "Organization"
  has_many    :children, class_name: "Organization"
  has_many    :organs

  field :name, localize: true
end
