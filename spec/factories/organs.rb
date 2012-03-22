  # -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organ do
    name  'Tasa-arvotyöryhmä'
    association :organization, :factory => :organization_leaf
  end
end
