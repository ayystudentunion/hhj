class Call
  include Mongoid::Document
  include Ext::Mongoid::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  validates :title, :member_amount, :deputy_amount, allow_blank: false, presence: true
  validates :status, presence: true, allow_blank: false, :format => { :with => /(open|closed|handled|archived)/ }

  belongs_to :organ
  has_many :position_applications
  has_and_belongs_to_many :eligibility_rule_sets

  field :title, localize: true
  field :status, type: Symbol, default: :open
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


  #def set_selected(id, position, my_member_id, my_deputy_id)
  def set_selected!(position_hash, member_or_deputy_id)
    return if position_hash.nil? or position_hash.empty?

    position_hash.each do |id, position|
      application = position_applications.find(id)
      application.selected_as = position
      my_member_or_deputy = member_or_deputy_id.blank? ? nil : PositionApplication.find(member_or_deputy_id)

      application.my_deputy = nil
      application.my_member = nil
      unless my_member_or_deputy.nil?
        my_member_or_deputy.my_member = nil
        my_member_or_deputy.my_deputy = nil
      end

      if application.selected_as == :position_member
        application.my_deputy = my_member_or_deputy
      elsif application.selected_as == :position_deputy
        application.my_member = my_member_or_deputy
      end
      application.save!
    end
  end

  def has_unhandled_applications
    position_applications.where(selected_as: nil).exists?
  end

  def file_name
    ::Sanitizer.sanitize_filename(title + '_' + I18n.l(updated_at, format: :file))
  end

end
