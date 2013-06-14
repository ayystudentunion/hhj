class Alliance
  include Mongoid::Document

  field :name, type: String

  belongs_to :call
  belongs_to :creator, class_name: "User", inverse_of: :alliances
  has_many :position_applications

  validates_presence_of :creator

  def members
    self.position_applications.map{|application| application.user}
  end

end
