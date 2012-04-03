
open_modal_dialog = (url) ->
  wrap = $('#modal-wrap').empty().show()
  # TODO: use uncached get for edit modals
  cached.get url + ".fragment", (error, data) ->
    $(data).appendTo wrap
    uniformify wrap
    wrap.find('.field.date').datepicker
      firstDay: 1
      buttonImageOnly: true
      showOn: 'both'
      dateFormat: 'dd.mm.yy'
      buttonImage: '/img/calendar-icon.png'

init_modals = () ->
  $('a.js-modal').live 'click', () ->
    href = $(this).attr 'href'
    open_modal_dialog href
    return false

  $('#modal-wrap').delegate '.close-modal', 'click', () ->
    $('#modal-wrap').empty().hide()

  $("#modal-wrap").delegate ".lang.btn", "click", () ->
    changeModalFormLanguage = (forms_container, locale) ->
      forms_container.find('.localized').hide()
      forms_container.find(".localized.#{locale}").show()
      forms_container.find('.lang.btn').toggleClass('active', false)
      forms_container.find(".lang.btn[hreflang='#{locale}']").toggleClass('active', true)

    changeModalFormLanguage $(this).parents('.content:first'), $(this).attr('hreflang')

  $("#modal-wrap").delegate "select", "change", () ->
    select = $(this)
    organization_id = select.val()
    select.nextAll().remove()

    $.get $("#modal-wrap .modal").attr('data-url'), (organizations) ->
      children = _(organizations).filter((org) -> org.parent_id == organization_id)
      if children.length > 0
        template = $($("#organization-select-template").html())
        select.parents('.inline-block:first').append template
        template.render(children, item: -> value: "#{@_id}", text: "#{@name}")
        default_option = select.children('option').first().clone().attr('selected', 'selected')
        template.prepend(default_option).uniform()

    return false

  $("#modal-wrap").delegate "#send-application .radio input", "change", () ->
    itemRow = $(this).parents('.item-row:first')
    itemRow.find("#position_application_deputy_of").toggle($(this).val() != 'position_member')

$(init_modals)
