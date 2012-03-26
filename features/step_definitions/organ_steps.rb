# coding: utf-8
Then %r/^I should see a list of organs$/ do
  page.should have_content "Tasa-arvotyöryhmä"
  page.should have_content "Kirjakerho"
end

Then %r/^I should see the organ page for "([^"]*)"$/ do |organ_name|
  page.find(".organ-details h2").should have_content organ_name
end