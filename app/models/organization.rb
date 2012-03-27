class Organization
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Timestamps

  has_many  :organs

  field     :name, localize: true
end
