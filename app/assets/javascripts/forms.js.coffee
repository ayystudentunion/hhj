
initRadioButtons = (delegateFor) ->
  delegateFor.delegate ".status-buttons .radio input,.buttons .radio input", "change", () ->
    buttons = $(this).parents('.status-buttons,.buttons').first()
    buttons.find('.btn').removeClass('checked')
    $(this).parents('.btn:first').addClass('checked')

uniformify = (node) ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()

initOrganPage = (delegateFor) ->
  toggleArchived = (visible) ->
    $('.archived-call-for-applications').toggle visible
    $('.hide-archived').toggle visible
    $('.show-archived').toggle not visible

  delegateFor.delegate ".show-archived", "click", () ->
    toggleArchived true
    return false

  delegateFor.delegate ".hide-archived", "click", () ->
    toggleArchived false
    return false

window.initDom = (selector) ->
  node = $(selector)
  uniformify node
  initRadioButtons node
  initOrganPage node
  return node

