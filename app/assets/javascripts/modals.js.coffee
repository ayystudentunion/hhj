

@open_modal_dialog = (url) ->
  wrap = $('#modal-wrap').empty().fadeIn('fast')
  cached.clear(); #added afterwards to refresh electoral alliances list after creating one
  # TODO: use uncached get for edit modals
  cached.get url + ".fragment", (error, data) ->
    $(data).appendTo wrap
    initDom wrap
    wrap.find('.field.date').datepicker
      firstDay: 1
      buttonImageOnly: true
      showOn: 'both'
      dateFormat: 'dd.mm.yy'
      buttonImage: '/img/calendar-icon.png'
    org_path = wrap.find('#organization-path').text()
    if org_path
      async.mapSeries org_path.split('|'), choose_org(wrap), (()->) if org_path

choose_org = (parent) -> (id, cb) ->
  option = parent.find("option[value='#{id}']")
  select = option.parent()
  select.unbind("resolved").bind("resolved", () -> cb())

  #select.find("option").removeAttr("selected")
  #option.attr("selected", "selected")
  select.val(id).change()
  #$.uniform.update()

init_modals = () ->
  $('a.js-modal').live 'click', () ->
    href = $(this).attr 'href'
    open_modal_dialog href
    return false

  $('#modal-wrap').delegate '.close-modal', 'click', () ->
    $('#modal-wrap').fadeOut('fast')
    if $(this).attr('href') == '#'
      return false

  $('#modal-wrap').delegate '.js-submit', 'click', (e) ->
    form = $(this).parents('form')
    $.post form.attr('action'), form.serialize(), (data) ->
      wrap = $('#modal-wrap')
      $(data).appendTo wrap.empty()
      initDom wrap
    return false

  $("#modal-wrap").delegate ".lang.btn", "click", () ->
    changeModalFormLanguage = (forms_container, locale) ->
      forms_container.find('.localized').hide()
      forms_container.find(".localized.#{locale}").show()
      forms_container.find('.lang.btn').toggleClass('active', false)
      forms_container.find(".lang.btn[hreflang='#{locale}']").toggleClass('active', true)

    changeModalFormLanguage $(this).parents('.content:first'), $(this).attr('hreflang')
    return false

  $("#modal-wrap").delegate "select.organizations", "change", () ->
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
        template.prepend(default_option) #.uniform()
      select.trigger("resolved")

    return false

  $("#modal-wrap").delegate "#send-application .radio input", "change", (e) ->
    $(this).parents('.item-row:first').find("#position_application_deputy_of").toggle($(this).val() == 'position_deputy')
    event.preventDefault()

  $("#modal-wrap").delegate "#send-application-for-administrational-call .radio input", "change", (e) ->
    pair_selects = $(this).parents('.item-row:first').find(".pair-select")
    shown_id = "show_when_#{$(this).val()}_selected"
    $(pair_select).toggle(shown_id == $(pair_select).attr('id')) for pair_select in pair_selects
    event.preventDefault()


  $("#modal-wrap").delegate "#send-application-for-administrational-call  .email-reminder-fields input[type=checkbox]", "change", () ->
    $(this).parents('.email-reminder-fields').find('input[type=text]').toggle()

  $("#modal-wrap").delegate "#new-alliance .call select", "change", () ->
    $('.applications_lists .applications_for_one_call').hide()
    $('.applications_lists input:checkbox').prop('checked', false)
    $.uniform.update()
    $("#applications-for-call-" + $(this).val()).show()

$(init_modals)
