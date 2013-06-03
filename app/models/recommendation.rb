class Recommendation
  include Mongoid::Document

  belongs_to :position_application
  belongs_to :user

  validates_presence_of :position_application
  validates_presence_of :user

end
