# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name  'Spartan Teknillinen Yliopisto'
  end

  factory :organization_node, :class => Organization do
    name  'Luonnontieteellinen tiedekunta'
    association :parent, :factory => :organization
  end

  factory :organization_leaf, :class => Organization do
    name  'Kemian laitos'
    association :parent, :factory => :organization_node
  end
end
