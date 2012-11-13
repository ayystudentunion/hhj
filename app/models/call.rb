class Call
  include Mongoid::Document
  include Ext::Mongoid::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  WORKFLOW_VALUES = [:workflow_normal, :workflow_administration_election, :workflow_proposal_available]

  belongs_to :organ, dependent: :nullify
  has_many :position_applications
  belongs_to :eligibility_rule_set
  before_save :render_description

  validates :title, :member_amount, :deputy_amount, allow_blank: false, presence: true
  validates :status, presence: true, allow_blank: false, :format => { :with => /(open|closed|handled|archived|proposed)/ }
  validates :workflow, presence: true, allow_blank: false, inclusion: { in:  WORKFLOW_VALUES }

  field :title, localize: true
  field :status, type: Symbol, default: :open
  field :workflow, type: Symbol, default: :workflow_normal
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
  field :rendered_description, localize: true
  scope :open, where(status: :open)
  
  def render_description
    renderer = Redcarpet::Render::HTML.new
    extensions = {}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_description = redcarpet.render self.description
  end
  
  def self.open_by_university(university)
    open.select{|c| c.organ.belongs_to?(university)}
  end

  def has_unhandled_applications
    position_applications.not_selected.exists?
  end

  def file_name
    ::Sanitizer.sanitize_filename(title + '_' + I18n.l(updated_at, format: :file))
  end

  def selected_with_deputies
    members = position_applications.members.map{|a| [a, a.deputy]}
    lone_deputies = position_applications.lone_deputies.map{|a| [nil, a]}
    members + lone_deputies
  end

end
