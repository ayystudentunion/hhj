class Organization
  include Mongoid::Document

  field :name, type: String

  belongs_to  :parent, class_name: "Organization"
end
