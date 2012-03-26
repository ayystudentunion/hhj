# coding: utf-8

Then /^I should see a list of organs$/ do
  page.has_content? "Tasa-arvotyöryhmä"
  page.has_content? "Kirjakerho"
end
