class Recommendation
  include Mongoid::Document

  belongs_to :position_application
  belongs_to :user

  validates_presence_of :position_application
  validates_presence_of :user

  index({ position_application: 1, user: 1 }, { unique: true, drop_dups: true })

end
