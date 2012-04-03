# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    factory :eija do
      _id        '4f7963bf91bc2bc1f6000001'
      first_name 'Eija'
      last_name  'Zitting'
      email      'eija.zitting@ayy.fi'
      phone      '+358 40 123 1234'
    end
  end
end
