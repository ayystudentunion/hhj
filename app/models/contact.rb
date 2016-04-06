class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :university, class_name: 'Organization'

  validates :email, presence: true, email: true
  validates :name, presence: true, allow_blank: false

  field :name, type: String
  field :email, type: String
  field :phone_number, type: String
end
