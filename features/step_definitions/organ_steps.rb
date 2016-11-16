# coding: utf-8
Then /^I should see a list of organs$/ do
  page.should have_content "Tasa-arvotyöryhmä"
  page.should have_content 'Kirjakerho'
end

Then /^I should see the organ page for '([^']*)'$/ do |organ_name|
  section(organ_name).should have_content organ_name
end

Then /^I should see introduction of organ '([^']*)' with description '([^']*)':$/ do |organ_name, description, table|
  details = section(organ_name)
  details.should have_content description
end

When /^I press the edit icon for '([^']*)'$/ do |organ_name|
  within section(organ_name) do
    find('.edit-icon').click
  end
end

Then /^I should see (:?exactly )?the following persons in '([^']*)':$/ do |exactly, title, table|
  members = find(:xpath, "//div[(h2|h3)[contains(text(),'#{title}')]]")
  table.hashes.each do |row|
    member = members.find(".member-card:contains('#{row[:name]}'), .member-list-item:contains('#{row[:email]}')")
    member.should have_css("*:contains('#{row[:term]}')")
    member.should have_css("*:contains('#{row[:position]}')")
  end

  members.all('.member-card, .member-list-item').count.should == table.hashes.count unless exactly.nil?
end

Given /^"([^"]*)" has enabled recommendations with threshold of (\d+)$/ do |uni_name, threshold|
  university = Organization.roots.where(name: uni_name).first
  university.update_attributes(recommendations_threshold: threshold)
end

Given /^"([^"]*)" has not enabled recommendations$/ do |uni_name|
  university = Organization.roots.where(name: uni_name).first
  university.update_attributes(recommendations_threshold: nil)
end
