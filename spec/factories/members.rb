# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    organ { TestSingletons.kirjakerho }
    user { TestSingletons.eija }
  end
end
