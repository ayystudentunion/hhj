class Alliance
  include Mongoid::Document

  field :name, type: String

  belongs_to :creator, class_name: "User"
  has_many :members, class_name: "User"

end
