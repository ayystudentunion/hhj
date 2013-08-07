# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    association :university, :factory => :spartan_teknillinen_yliopisto
    factory :eija do
      _id        '4f7963bf91bc2bc1f6000001'
      first_name 'Eija'
      last_name  'Zitting'
      email      'eija.zitting@sty.fi'
      phone      '+358 40 123 1234'
      principal_name 'eizit@sty.fi'
      role       :role_union_employee
    end
    factory :aaro do
      _id        '4f7963bf91bc2bc1f6000005'
      first_name 'Aaro'
      last_name  'Häkkinen'
      email      'aaro.hakkinen@sty.fi'
      phone      '+358 40 123 1234'
      principal_name 'aaroha@sty.fi'
      role       :role_university_staff
    end
    factory :student_martti do
      _id        '4f7963bf91bc2bc1f6000002'
      first_name 'Martti'
      last_name  'Pulliainen'
      email      'martti@sty.fi'
      phone      '+358 40 555 4321'
      principal_name 'marpul@sty.fi'
    end
    factory :student_tiina do
      _id        '4f7963bf91bc2bc1f6000007'
      first_name 'Tiina'
      last_name  'Kumpulainen'
      email      'tiina@sty.fi'
      phone      '+358 40 555 4999'
      principal_name 'tiina@sty.fi'
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
      association :university, :factory => :akhaimenidien_yliopisto
      _id        '4f7963bf91bc2bc1f6000006'
      first_name 'Xerxes'
      last_name  'I'
      email      'xerxes@ay.fi'
      phone      '+358 40 555 7777'
      principal_name 'xerxes@ay.fi'
      role       :role_union_employee
    end
  end
  factory :helsinki_uni_user, class: User do
    factory :helsinki_uni_student_anna do
      association :university, :factory => :helsinki_uni
      _id        '4f7963bf91bc2bc1f6000077'
      first_name 'Anna'
      last_name  'Kainulainen'
      email      'anna.kainulainen@helsinki.fi'
      phone      '+358 40 123 1234'
      principal_name 'anna@helsinki.fi'
      role       :role_student
    end
    factory :helsinki_uni_student_tiina do
      association :university, :factory => :helsinki_uni
      _id        '4f7963bf91bc2bc1f6000078'
      first_name 'Tiina'
      last_name  'Miettinen'
      email      'tiina.miettinen@helsinki.fi'
      phone      '+358 40 123 1234'
      principal_name 'tiina@helsinki.fi'
      role       :role_student
    end
    factory :helsinki_uni_student_pekka do
      association :university, :factory => :helsinki_uni
      _id        '4f7963bf91bc2bc1f6000078'
      first_name 'Pekka'
      last_name  'Jantunen'
      email      'pekka@helsinki.fi'
      phone      '+358 40 123 1234'
      principal_name 'pekka@helsinki.fi'
      role       :role_student
    end
  end
end
