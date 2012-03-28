
Given /^there exist university organization$/ do
  Factory :fysiikan_laitos
  Factory :kemian_laitos
  Factory :kirjasto
end



Given /^there are several organs in the system$/ do
  Factory :tasa_arvotyoryhma
  Factory :kirjakerho
end
