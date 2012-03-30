# -*- encoding : utf-8 -*-

Given %r/^there exist university organization$/ do
  FactoryGirl.create :fysiikan_laitos
  FactoryGirl.create :kemian_laitos
  FactoryGirl.create :kirjasto
end

Given %r/^there are several organs in the system$/ do
  FactoryGirl.create :tasa_arvotyoryhma
  FactoryGirl.create :kirjakerho
end

Given %r/^there exists an organ 'Tasa-arvotyöryhmä'$/ do
  FactoryGirl.create :tasa_arvotyoryhma
end

