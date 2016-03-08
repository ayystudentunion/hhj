# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    factory :helsinki_uni do
      name  'Helsingin yliopisto'
      key   'helsinki'
      recommendations_threshold 3
      _id   '4f6b1edf91bc2b33d3010300'
    end

    factory :spartan_teknillinen_yliopisto do
      name  'Spartan Teknillinen Yliopisto'
      key   'sty'
      _id   '4f6b1edf91bc2b33d3010000'
    end

    factory :luonnontieteellinen_tiedekunta do
      name  'Luonnontieteellinen tiedekunta'
      _id   '4f6b1edf91bc2b33d3010100'
      parent { TestSingletons.sparta }
    end

    factory :kirjasto do
      name  'Kirjasto'
      _id   '4f6b1edf91bc2b33d3010200'
      parent { TestSingletons.sparta }
    end

    factory :kemian_laitos do
      name  'Kemian laitos'
      _id   '4f6b1edf91bc2b33d3010101'
      parent { TestSingletons.luonnontieteellinen_tiedekunta }
    end

    factory :fysiikan_laitos do
      name  'Fysiikan laitos'
      _id   '4f6b1edf91bc2b33d3010102'
      parent { TestSingletons.luonnontieteellinen_tiedekunta }
    end

    factory :akhaimenidien_yliopisto do
      name  'Akhaimenidien Yliopisto'
      key   'ay'
      _id   '5e5c1edf91bc2b3300000000'
    end

    factory :akhaimenidien_kirjasto do
      name  'Akhaimenidien Kirjasto'
      _id   '5e5c1edf91bc2b3302000000'
      parent { FactoryGirl.create(:akhaimenidien_yliopisto) }
    end
  end
end
