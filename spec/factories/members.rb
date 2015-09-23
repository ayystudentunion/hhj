# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    association :organ, :factory => :kirjakerho
    association :user, :factory => :eija
  end
end
