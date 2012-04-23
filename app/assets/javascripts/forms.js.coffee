
initRadioButtons = (delegateFor) ->
  delegateFor.delegate ".status-buttons .radio input,.buttons .radio input", "change", () ->
    buttons = $(this).parents('.status-buttons,.buttons').first()
    buttons.find('.btn').removeClass('checked')
    $(this).parents('.btn:first').addClass('checked')

uniformify = (node) ->
  $("input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()

initOrganPage = (delegateFor) ->
  initToggleArchived = () ->
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

  initCallSelectionDragNDrops = () ->
    $('.call-for-application.open .member-card').draggable
      revert: 'invalid'

    $('.call-for-application.open .applicants').droppable
      drop: (event, ui) ->
        $(@).append(ui.draggable)
        ui.draggable.position
          my: "top left"
          at: "top left"
          of: $(this)

    $('.call-for-application.open .member-card-empty').droppable
      accept: (draggable) ->
        return false unless draggable.hasClass 'member-card'
        return false if $(@).find('.member-card').length > 0
        true
      drop: (event, ui) ->
        $(@).prepend(ui.draggable)
        ui.draggable.position
          my: "top left"
          at: "top left"
          of: $(this)

  initToggleArchived()
  initCallSelectionDragNDrops()


initPopups = (delegateFor) ->
  delegateFor.delegate "a.popup", "click", () ->
    window.open $(this).prop 'href'
    return false

window.initDom = (selector) ->
  node = $(selector)
  uniformify node
  initRadioButtons node
  initOrganPage node
  initPopups node
  return node

