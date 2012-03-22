# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spartan_teknillinen_yliopisto, :class => Organization do
    name  'Spartan Teknillinen Yliopisto'
    _id   '4f6b1edf91bc2b33d3000001'
  end

  factory :luonnontieteellinen_tiedekunta, :class => Organization do
    name  'Luonnontieteellinen tiedekunta'
    _id   '4f6b1edf91bc2b33d3000002'
    parent Factory(:spartan_teknillinen_yliopisto)
  end

  factory :kemian_laitos, :class => Organization do
    name  'Kemian laitos'
    _id   '4f6b1edf91bc2b33d3000003'
    parent  Factory(:luonnontieteellinen_tiedekunta)
  end
end
