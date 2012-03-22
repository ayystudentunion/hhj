  # -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organ do
    factory :tasa_arvotyoryhma, :class => Organ do
      name  'Tasa-arvotyöryhmä'
      _id   "4f6b1edf91bc2b3301010101"
      association :organization, :factory => :kemian_laitos
    end
    factory :kirjakerho, :class => Organ do
      name  'Kirjakerho'
      _id   "4f6b1edf91bc2b3302010101"
      association :organization, :factory => :kirjasto
    end
  end
end
