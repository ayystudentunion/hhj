def check_details(details_selector, title, description, table)
  details = page.find details_selector
  details.find("h2").should have_content title
  details.should have_content description

  table.hashes.each do |row|
    details.find(".label:contains('#{row[:label]}') + span").should have_content row[:value]
  end
end

def check_that_contains_values(container_selector, *values)
  values.each{ |value| find(container_selector).should have_content value }
end
