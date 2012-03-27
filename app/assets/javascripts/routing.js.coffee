
loadFragment = (locale, controller, param) ->
  locale     ?= "fi"
  controller ?= "" # TODO
  param      ?= ""

  url = "/#{locale}"
  if controller
    url += "/#{controller}"
    if param
      url += "/#{param}"

  url += ".fragment"

  contentWrap = $('#content-wrapper').empty()
  cached.getDOM url, (error, dom) ->
    dom.appendTo contentWrap

  modal = $(document).getUrlParam "modal"
  if modal
    ; # TODO

init_routing = () ->
  console.log "init_routing"
  return if not History.enabled
  crossroads.addRoute "/{locale}/:controller:/:param:", loadFragment
  crossroads.routed.add(console.log, console);

  $('a').live 'click', (ev) ->
    href = $(this).attr 'href'
    if href.indexOf('http://') == 0
      return true
    else
      navigate href
      return false

  History.Adapter.bind window, 'statechange', () ->
    console.log History.getState()
    navigate History.getState().hash

navigate = (url) ->
  History.pushState null, null, url
  crossroads.parse url

$(init_routing)