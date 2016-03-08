FactoryGirl.define do
  factory :recommendation do
    association :position_application, factory: :kirjakerho_application
    user { TestSingletons.eija }
  end
end
