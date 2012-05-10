class User
  include Mongoid::Document
  include Mongoid::Timestamps

  validates :email, :presence => true, :email => true

  field :principal_name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :university_domain, type: String
  field :email, type: String
  field :phone, type: String
  field :role, type: String
  field :edu_data, type: Hash

  has_many :position_applications
  has_many :members

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def university
    university_domain.split(".").first if university_domain
  end

  def self.update_or_create_from_env(env)
    attrs = env_to_attributes(env)
    pn = attrs[:principal_name]
    if pn
      user = User.where(:$or => [{email: attrs[:email]}, {principal_name: pn}]).first
      user = User.create! attrs if user.nil?
      user.update_attributes!(attrs)
      user
    end
  end

  def self.env_to_attributes(env)
    # The environment variables in this block need to be
    # configured in Shibboleth.
    return {
      principal_name: env["A_PRINCIPAL_NAME"],
      first_name: env["A_GIVEN_NAME"],
      last_name: env["A_SURNAME"],
      email: env["A_MAIL"],
      phone: env["A_MOBILE"],
      university_domain: env["A_HOME_ORGANIZATION"],
      edu_data: env.select{|k,v| k.starts_with?("A_")}
    }
  end

  def can_edit_call_results?
    true
  end
end
