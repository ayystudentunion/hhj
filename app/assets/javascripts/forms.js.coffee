
initRadioButtons = (delegateFor) ->
  delegateFor.delegate ".status-buttons .radio input,.buttons .radio input", "click", () ->
    $(this).parents('.status-buttons,.buttons').first().find('.btn').removeClass('checked')
    $(this).parents('.btn:first').addClass('checked')

uniformify = (node) ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()

initOrganPage = (delegateFor) ->
  delegateFor.delegate ".show-archived", "click", () ->
    $('.archived-call-for-applications').toggle true
    $('.hide-archived').toggle true
    $('.show-archived').toggle false
    return false

  delegateFor.delegate ".hide-archived", "click", () ->
    $('.archived-call-for-applications').toggle false
    $('.hide-archived').toggle false
    $('.show-archived').toggle true
    return false

window.initDom = (selector) ->
  node = $(selector)
  uniformify node
  initRadioButtons node
  initOrganPage node
  return node

