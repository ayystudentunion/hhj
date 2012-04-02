class User
  include Mongoid::Document

  validates :first_name, :last_name, :email, allow_blank: false, presence: true

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone, type: String

  has_many :position_applications

  def full_name
    first_name + ' ' + last_name
  end
end
