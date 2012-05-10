# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    factory :eija do
      _id        '4f7963bf91bc2bc1f6000001'
      first_name 'Eija'
      last_name  'Zitting'
      email      'eija.zitting@sty.fi'
      phone      '+358 40 123 1234'
      principal_name 'eizit@sty.fi'
      role       'employee'
    end
    factory :aaro do
      _id        '4f7963bf91bc2bc1f6000005'
      first_name 'Aaro'
      last_name  'Häkkinen'
      email      'aaro.hakkinen@sty.fi'
      phone      '+358 40 123 1234'
      principal_name 'aaroha@sty.fi'
      role       'admin_staff'
    end
    factory :student_martti do
      _id        '4f7963bf91bc2bc1f6000002'
      first_name 'Martti'
      last_name  'Pulliainen'
      email      'martti@sty.fi'
      phone      '+358 40 555 4321'
      principal_name 'marpul@sty.fi'
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
    factory :xerxes do
      _id        '4f7963bf91bc2bc1f6000006'
      first_name 'Xerxes'
      last_name  'I'
      email      'xerxes@ay.fi'
      phone      '+358 40 555 7777'
      principal_name 'xerxes@ay.fi'
      role       'employee'
    end
  end
end
