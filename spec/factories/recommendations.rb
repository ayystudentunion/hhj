FactoryGirl.define do
  factory :recommendation do
    association :position_application, :factory => :kirjakerho_application
    association :user, :factory => :eija
  end
end
