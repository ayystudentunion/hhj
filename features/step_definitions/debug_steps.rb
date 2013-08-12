Then /^debugger$/ do
  debugger
end

When /^take a screenshot$/ do
  screenshot_and_open_image
end

Then %r/^show me the page$/ do
  save_and_open_page
end
