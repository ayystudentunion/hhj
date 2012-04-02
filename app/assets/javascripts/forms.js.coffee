
window.uniformify = (selector) ->
  node = $(selector)
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()
  return node