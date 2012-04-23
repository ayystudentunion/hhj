class Call
  include Mongoid::Document
  include Ext::Mongoid::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  validates :title, :member_amount, :deputy_amount, allow_blank: false, presence: true
  validates :status, presence: true, :format => { :with => /(open|closed|handled|archived)/ }

  belongs_to :organ
  has_many :position_applications
  has_and_belongs_to_many :eligibility_rule_sets

  field :title, localize: true
  field :status, type: Symbol, default: :open
  field :closed, type: Boolean, default: false
  field :archived, type: Boolean, default: false
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

    position_results.each do |id, position|
      application = position_applications.find(id)
      application.selected_as = position
      application.save
    end
  end

  def has_unhandled_applications
    position_applications.where(selected_as: nil).exists?
  end

  def file_name
    ::Sanitizer.sanitize_filename(title + '_' + I18n.l(updated_at, format: :file))
  end

end
