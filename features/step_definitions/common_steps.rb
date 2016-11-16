def section(title)
  # Parent of element that contains title
  find('h2', text: title).find(:xpath, '..')
end
