class Alliance
  include Mongoid::Document

  field :name, type: String

  belongs_to :call
  belongs_to :creator, class_name: "User", inverse_of: :alliances
  has_many :position_applications, :autosave => true

  validates_presence_of :creator

  validate :applications_must_belong_to_the_call

  def members
    self.position_applications.map{|application| application.user}
  end

  def applications_must_belong_to_the_call
    self.position_applications.each do |application|
       errors.add(:call, :does_not_match_applications) unless application.call == self.call
    end
  end

end
