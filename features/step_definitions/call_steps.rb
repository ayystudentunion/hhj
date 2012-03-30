Then %r/^I should see call for application '([^']*)' with description '([^']*)':$/ do |call_name, description, table|
  details = page.find(".call-details")
  details.find("h2").should have_content call_name
  details.should have_content description

  table.hashes.each do |row|
    details.find(".label:contains('#{row[:label]}') + span").should have_content row[:value]
  end
end
