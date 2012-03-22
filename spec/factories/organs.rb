  # -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tasa_arvotyoryhma, :class => Organ do
    name  'Tasa-arvotyöryhmä'
    association :organization, :factory => :kemian_laitos
  end
end
