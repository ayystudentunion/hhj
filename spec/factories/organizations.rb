# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name  'Spartan Teknillinen Yliopisto'
    _id   '4f6b1edf91bc2b33d3000001'
  end

  factory :organization_node, :class => Organization do
    name  'Luonnontieteellinen tiedekunta'
    _id   '4f6b1edf91bc2b33d3000002'
    parent Factory(:organization)
  end

  factory :organization_leaf, :class => Organization do
    name  'Kemian laitos'
    _id   '4f6b1edf91bc2b33d3000003'
    parent  Factory(:organization_node)
  end
end
