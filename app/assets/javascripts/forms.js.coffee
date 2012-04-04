
initRadioButtons = (delegateFor) ->
  delegateFor.delegate ".buttons .radio input", "change", () ->
    $(this).parents('.buttons:first').find('.btn').removeClass('checked')
    $(this).parents('.btn:first').addClass('checked')

uniformify = (node) ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()

window.initDom = (selector) ->
  node = $(selector)
  uniformify node
  initRadioButtons node
  return node

