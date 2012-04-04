
window.initRadioButtons = (delegateFor) ->
  check = (input) ->
    input.parents('.buttons:first').find('.btn').removeClass('checked')
    input.parents('.btn:first').addClass('checked')

  if delegateFor?
    delegateFor.delegate ".radio input", "change", () ->
      check $(this)
  else
    $('.buttons .radio input').change () ->
      check $(this)

window.uniformify = (selector) ->
  node = $(selector)
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()
  return node
