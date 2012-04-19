# coding: utf-8
Then %r/^I should see a list of organs$/ do
  page.should have_content "Tasa-arvotyöryhmä"
  page.should have_content "Kirjakerho"
end

Then %r/^I should see the organ page for '([^']*)'$/ do |organ_name|
  page.find(".organ-details h2").should have_content organ_name
end

Then %r/^I should see introduction of organ '([^']*)' with description '([^']*)':$/ do |organ_name, description, table|
  check_details '.organ-details', organ_name, description, table
end

When %r/^I press the edit icon$/ do
  page.find(".edit-icon").click
end


Then %r/^I should see (:?exactly )?the following persons in '([^']*)':$/ do |exactly, title, table|
  members = find(:xpath, "//div[(h2|h3)[contains(text(),'#{title}')]]")
  table.hashes.each do |row|
    member = members.find(".member-card:contains('#{row[:name]}')")
    member.find("*:contains('#{row[:term]}')")
    member.find("*:contains('#{row[:position]}')")
  end

  members.all('.member-card').count.should == table.hashes.count unless exactly.nil?
end

