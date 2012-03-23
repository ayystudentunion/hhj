class Organization
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to  :parent, class_name: "Organization"
  has_many    :children, class_name: "Organization"
  has_many    :organs

  field :name, localize: true
end
