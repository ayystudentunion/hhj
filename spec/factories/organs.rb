# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organ do
    official true
    factory :tasa_arvotyoryhma do
      name  'Tasa-arvotyöryhmä'
      description {{fi:'Työryhmä varmistaa tasa-arvon toteutumisen', en:'Organ assures fulfilling of equality'}}
      _id   "4f6b1edf91bc2b3301010101"
      association :organization, :factory => :kemian_laitos
    end
    factory :kirjakerho do
      name  'Kirjakerho'
      _id   "4f6b1edf91bc2b3302010101"
      organization { TestSingletons.kirjasto }
    end
    factory :akhaimenidien_kirjakerho do
      name  'Akhaimenidien Kirjakerho'
      _id   "5e5c1edf91bc2b3302000001"
      association :organization, :factory => :akhaimenidien_kirjasto
    end
    factory :helsinki_uni_student_council do
      name 'Helsingin yliopiston opiskelijahallitus'
      _id "5e5c1edf91bc2b3302000003"
      organization { TestSingletons.helsinki }
    end
    factory :helsinki_uni_alumni_council do
      name 'Helsingin yliopiston alumnien yhteistyöelin'
      _id "5e5c1edf91bc2b3302000005"
      organization { TestSingletons.helsinki }
    end

  end
end
