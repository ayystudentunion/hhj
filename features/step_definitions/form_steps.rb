
def fillFieldByPlaceholder(form, placeholder, value)
  form.all("*[placeholder='#{placeholder}']").map { |input| input.set(value) }.any?
end

def fillFieldByLabel(form, label, value)
  form.all("label:contains('#{label}') ~ input").map { |input| input.set(value) }.any?
end

def fill_in_form (form, data)
  data.each do |row|
    next if fillFieldByPlaceholder form, row[:label], row[:value]
    next if fillFieldByLabel form, row[:label], row[:value]
    form.fill_in row[:label], with: row[:value]
  end
end

When /^fill in form "([^"]*)":$/ do |form_title, table|
  form = find("*:contains('#{form_title}') ~ form")
  fill_in_form form, table.hashes
end


