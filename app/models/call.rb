class Call
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  validates :title, :member_amount, :deputy_amount, allow_blank: false, presence: true

  belongs_to :organ
  has_many :position_applications

  field :title, localize: true
  field :closed, type: Boolean, default: false
  field :member_amount, type: Integer, default: 0
  field :deputy_amount, type: Integer, default: 0
  field :quota_information, localize: true
  field :date_open, type: Date
  field :date_start, type: Date
  field :date_end, type: Date
  field :term_start, type: Date
  field :term_end, type: Date
  field :appointment_place_and_date, localize: true
  field :description, localize: true

  def set_results(position_results)
    return if position_results.nil? or position_results.empty?
    set_results_to_applications(position_results)
    create_new_members(position_results)
  end

  protected

  def set_results_to_applications(position_results)
    position_results.each do |position, ids|
      ids.each do |id|
        application = position_applications.find(id)
        application.selected_as = position
        application.save
      end
    end
  end

  def create_new_members(position_results)
    members_and_deputies = position_results.select{ |position, ids|
      [:position_member, :position_deputy].include? position.to_sym
    }

    members_and_deputies.each do | position, ids|
      ids.each do |id|
        Member.create(user: id, position: position)
      end
    end
  end

end
