
open_modal_dialog = (url) ->
  wrap = $('#modal-wrap').empty().show()
  # TODO: use uncached get for edit modals
  cached.get url + ".fragment", (error, data) ->
    $(data).appendTo wrap
    $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", wrap).uniform()
    wrap.find('.field.date').datepicker
      firstDay: 1
      buttonImageOnly: true
      showOn: 'both'
      dateFormat: 'dd.mm.yy'
      buttonImage: '/img/calendar-icon.png'

init_modal_links = () ->
  $('a.js-modal').live 'click', () ->
    href = $(this).attr 'href'
    open_modal_dialog href
    return false

  $('#modal-wrap').delegate '.close-modal', 'click', () ->
    $('#modal-wrap').empty().hide()

$(init_modal_links)
