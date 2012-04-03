# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call do
    factory :lukurinki do
      title "Kirjakerhon lukurinki"
      member_amount 2
      deputy_amount 1
      _id "4f6b1edf91bc2b4403020202"
      association :organ, :factory => :kirjakerho
    end
  end
end
