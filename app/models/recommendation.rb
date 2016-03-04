class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :position_application
  belongs_to :user

  validates :position_application, presence: true
  validates :user, presence: true

  index({ position_application: 1, user: 1 }, unique: true, drop_dups: true)
end
