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
    factory :student_martti do
      _id        '4f7963bf91bc2bc1f6000002'
      first_name 'Martti'
      last_name  'Pulliainen'
      email      'martti@spu.fi'
      phone      '+358 40 555 4321'
    end
    factory :student_emma do
      _id        '4f7963bf91bc2bc1f6000003'
      first_name 'Emma'
      last_name  'Saarioinen'
      email      'emma@spu.fi'
      phone      '+358 40 555 3333'
    end
    factory :student_topias do
      _id        '4f7963bf91bc2bc1f6000004'
      first_name 'Topias'
      last_name  'Lapinmaa'
      email      'tlap@spu.fi'
    end
  end
end
