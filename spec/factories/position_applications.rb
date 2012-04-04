# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_application do
    factory :kirjakerho_application do
      association :call, :factory => :lukurinki
      association :user, :factory => :eija
      position  :position_member
    end
  end
end
