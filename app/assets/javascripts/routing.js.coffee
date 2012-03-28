
loadFragment = (locale, controller, param, modal) ->
  locale     ?= "fi"
  controller ?= "" # TODO
  param      ?= ""

  url = "/#{locale}"
  if controller
    url += "/#{controller}"
    if param
      url += "/#{param}"

  url += ".fragment"

  contentWrap = $('#content-wrapper')
  cached.getDOM url, (error, dom) ->
    dom.appendTo contentWrap.empty()

  ###
  modalWrap = $('#modal-wrap').empty().hide()
  if modal
    modal_url = "/#{locale}/modals.fragment?modal=#{modal}"
    cached.getDOM modal_url, (error, dom) ->
      $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", dom).uniform()
      dom.appendTo modalWrap.show()
  ###

  return true

init_routing = () ->
  return if not History.enabled
  crossroads.addRoute "/{locale}/:controller:/:param:", loadFragment
  # crossroads.routed.add(console.log, console);

  $('a').live 'click', (ev) ->
    $this = $(this)
    href = $this.attr 'href'
    return false if $this.hasClass 'js-modal' or href == "#"
    if href.indexOf('http://') == 0
      return true
    else
      navigate href
      return false

  History.Adapter.bind window, 'statechange', () ->
    navigate History.getState().hash

navigate = (url) ->
  History.pushState null, null, url
  crossroads.parse url

$(init_routing)
