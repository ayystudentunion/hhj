class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLE_VALUES = [:role_student, :role_union_employee, :role_university_staff].freeze

  has_many :position_applications
  has_many :members
  has_many :recommendations, dependent: :destroy
  has_many :alliances, inverse_of: :creator

  belongs_to :university, class_name: 'Organization'

  validates :email, presence: true, email: true
  validates :role, presence: true, allow_blank: false, inclusion: { in:  ROLE_VALUES }

  field :principal_name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :university_domain, type: String
  field :email, type: String
  field :phone, type: String
  field :role, type: Symbol, default: :role_student
  field :edu_data, type: Hash

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def self.update_or_create_from_env(env)
    attrs = env_to_attributes(env)
    attrs.delete(:phone) unless PhoneNumberChecker.is_ok?(attrs[:phone])
    attrs[:email] = attrs[:email].split(';')[0] unless attrs[:email].nil? # Fix Abo Akademi problem
    principal_name = attrs[:principal_name]
    domain = attrs[:university_domain]
    return nil unless principal_name && domain
    university = Organization.university_by_key domain.split('.').first
    return nil unless university
    user = university.users.find_by(:$or => [{ email: attrs[:email] }, { principal_name: principal_name }])
    if user.nil?
      user = university.users.create! attrs
    else
      user.update_attributes!(attrs)
    end
    user
  end

  def self.env_to_attributes(env)
    # The environment variables in this block need to be
    # configured in Shibboleth.
    last_name = env['A_SURNAME']
    common_name = env['A_COMMON_NAME']
    first_name = if common_name.nil?
                   env['A_GIVEN_NAME']
                 else
                   common_name.chomp(last_name).rstrip
                 end
    {
      principal_name: env['A_PRINCIPAL_NAME'],
      first_name: first_name,
      last_name: last_name,
      email: env['A_MAIL'],
      phone: env['A_MOBILE'],
      university_domain: env['A_HOME_ORGANIZATION'],
      edu_data: env.select { |k, _v| k.starts_with?('A_') }
    }
  end

  def can_edit_call_results?
    true
  end

  def alliance_memberships
    position_applications.flat_map(&:alliance_memberships).uniq
  end

  def active_alliance_memberships
    alliance_memberships.reject { |m| m.alliance.archived }
  end
end
