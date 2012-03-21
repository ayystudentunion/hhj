
def fillFieldByPlaceholder(form, placeholder, value)
  all("*[placeholder='#{placeholder}']").map { |field| field.set(value) }.empty?
end

def fill_in_form (form, data)
  data.each do |row|
    fillFieldByPlaceholder form, row[:label], row[:value]
  end
end

When /^fill in form "([^"]*)":$/ do |form_title, table|
  form = find("*:contains('#{form_title}') ~ form")
  fill_in_form form, table.hashes
end


