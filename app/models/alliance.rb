class Alliance
  include Mongoid::Document

  field :name, type: String

  belongs_to :creator, class_name: "User"
  belongs_to :call
  has_many :members, class_name: "User"

end
