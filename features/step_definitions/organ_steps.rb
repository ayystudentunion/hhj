# coding: utf-8
Then %r/^I should see a list of organs$/ do
  page.should have_content "Tasa-arvotyöryhmä"
  page.should have_content "Kirjakerho"
end

Then %r/^I should see the organ page for "([^"]*)"$/ do |organ_name|
  page.find(".organ-details h2").should have_content organ_name
end

Then %r/^I should see introduction of organ "([^"]*)" with description "([^"]*)":$/ do |organ_name, description, table|
  details = page.find(".organ-details")
  details.find("h2").should have_content organ_name
  details.should have_content description

  table.hashes.each do |row|
    details.find(".label:contains('#{row[:label]}') + span").should have_content row[:value]
  end
end
