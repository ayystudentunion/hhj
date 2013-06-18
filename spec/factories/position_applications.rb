# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_application do
    association :user, :factory => :eija
    position  :position_member
    factory :kirjakerho_application do
      association :call, :factory => :lukurinki
    end
  end
end

