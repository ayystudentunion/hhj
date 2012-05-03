# RailsAdmin config file. Generated on April 19, 2012 10:01
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_admin } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, Admin

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, Admin

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Halloped', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Call, EligibilityRule, EligibilityRuleSet, Member, Organ, Organization, PositionApplication, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Call, EligibilityRule, EligibilityRuleSet, Member, Organ, Organization, PositionApplication, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Call do
  #   # Found associations:
  #     configure :organ, :belongs_to_association
  #     configure :eligibility_rule_sets, :has_and_belongs_to_many_association
  #     configure :position_applications, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :organ_id, :bson_object_id         # Hidden
  #     configure :eligibility_rule_set_ids, :serialized         # Hidden
  #     configure :title, :string
  #     configure :closed, :boolean
  #     configure :archived, :boolean
  #     configure :member_amount, :integer
  #     configure :deputy_amount, :integer
  #     configure :quota_information, :string
  #     configure :date_open, :date
  #     configure :date_start, :date
  #     configure :date_end, :date
  #     configure :term_start, :date
  #     configure :term_end, :date
  #     configure :appointment_place_and_date, :string
  #     configure :description, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model EligibilityRule do
  #   # Found associations:
  #     configure :eligibility_rule_set, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :eligibility_rule_set_id, :bson_object_id         # Hidden
  #     configure :edu_field, :text
  #     configure :valid_values, :serialized   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model EligibilityRuleSet do
  #   # Found associations:
  #     configure :calls, :has_and_belongs_to_many_association
  #     configure :eligibility_rules, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :call_ids, :serialized         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Member do
  #   # Found associations:
  #     configure :organ, :belongs_to_association
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :organ_id, :bson_object_id         # Hidden
  #     configure :user_id, :bson_object_id         # Hidden
  #     configure :halloped, :boolean
  #     configure :position, :string
  #     configure :current, :boolean
  #     configure :term_start, :date
  #     configure :term_end, :date
  #     configure :removed_date, :date   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Organ do
  #   # Found associations:
  #     configure :organization, :belongs_to_association
  #     configure :calls, :has_many_association
  #     configure :members, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :organization_id, :bson_object_id         # Hidden
  #     configure :name, :string
  #     configure :description, :string
  #     configure :term_start, :date
  #     configure :term_end, :date
  #     configure :manager_name, :text
  #     configure :manager_email, :text
  #     configure :appointer, :text
  #     configure :official, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Organization do
  #   # Found associations:
  #     configure :children, :has_many_association
  #     configure :organs, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :parent_id, :bson_object_id         # Hidden
  #     configure :parent_ids, :serialized
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :name, :string
  #     configure :key, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model PositionApplication do
  #   # Found associations:
  #     configure :call, :belongs_to_association
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :position, :string
  #     configure :selected_as, :string
  #     configure :deputy_of, :text
  #     configure :personal_statement, :text
  #     configure :call_id, :bson_object_id         # Hidden
  #     configure :user_id, :bson_object_id         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :position_applications, :has_many_association
  #     configure :members, :has_many_association
  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :first_name, :text
  #     configure :last_name, :text
  #     configure :email, :text
  #     configure :phone, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
