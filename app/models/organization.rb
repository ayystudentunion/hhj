class Organization
  include Mongoid::Document

  field :name, localize: true

  belongs_to  :parent, class_name: "Organization"
end
