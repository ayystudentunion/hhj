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
    onSameForm = (elem1, elem2) ->
      elem1Form = elem1.parents('form:first').first()
      elem2Form = elem2.parents('form:first').first()
      elem1Form.attr('id') == elem2Form.attr('id')

    saveSelection = (droppable, draggable) ->
      form = droppable.parents('form:first').first()
      putUrl = () ->
        form.attr('action') + '.json'
      putParams = () ->
        form.serialize() + "&selected_as={#{draggable.data('id')}:#{droppable.data('name')}}"

      superagent.post(putUrl())
        .type('form-data')
        .send(putParams())
        .end () ->
          return true

    $('.call-for-application.open .member-card').draggable
      revert: 'invalid'

    $('.call-for-application.open .applicants').droppable
      activeClass: 'highlight-drop-area'
      drop: (event, ui) ->
        droppable = $(@)
        $(@).append(ui.draggable.removeAttr('style'))
        $(@).find('.member-card:even').removeClass('no-margin')
        $(@).find('.member-card:odd').addClass('no-margin')
        saveSelection(droppable, ui.draggable)
      accept: (draggable) ->
        return false unless draggable.hasClass 'member-card'
        onSameForm $(@), draggable

    $('.call-for-application.open .member-card-empty').droppable
      activeClass: 'highlight-drop-area'
      accept: (draggable) ->
        return false unless draggable.hasClass 'member-card'
        return false if $(@).find('.member-card').length > 0
        return false if $(@).hasClass('no-deputy')
        onSameForm $(@), draggable
      drop: (event, ui) ->
        droppable = $(@)
        droppable.prepend(ui.draggable)
        ui.draggable.position
          my: "top left"
          at: "top left"
          of: droppable
        saveSelection(droppable, ui.draggable)

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

