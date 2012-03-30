
def fillFieldByPlaceholder(form, placeholder, value)
  form.all("*[placeholder^='#{placeholder}']").select(&:visible?).map { |input| input.set(value) }.any?
end

def fillFieldByLabel(form, label, value)
  form.all("label:contains('#{label}') ~ input").map { |input| input.set(value) }.any?
end

def fillSelects(div, values)
  values.each_with_index do |value, index|
    select = div.find("select:nth-child(#{index + 1})")
    select.find("option:contains('#{value}')").select_option
  end
end

def fillRadio(div, value)
  return if value.nil?
  div.find("*:contains('#{value}')").click
end

def fillSelectsWithRadio(form, label, value)
  selectValue, radioValue = value.split '+'
  selectsDiv = form.first(".inline-block:contains('#{label}')")
  fillSelects selectsDiv, selectValue.split('/')
  fillRadio selectsDiv.find(:xpath, './following-sibling::div'), radioValue
  not selectsDiv.nil?
end

def fill_in_form (form, data)
  data.each do |row|
    next if fillFieldByPlaceholder form, row[:label], row[:value]
    next if fillFieldByLabel form, row[:label], row[:value]
    next if fillSelectsWithRadio form, row[:label], row[:value]
    form.fill_in row[:label], with: row[:value]
  end
end

When %r/^fill in form '([^']*)':$/ do |form_title, table|
  form = find("*:contains('#{form_title}') ~ form")
  fill_in_form form, table.hashes
end


