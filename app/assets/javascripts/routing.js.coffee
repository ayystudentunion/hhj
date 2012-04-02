
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

  contentWrap = $('#page-content')
  cached.getDOM url, (error, dom) ->
    uniformify dom.clone().appendTo(contentWrap.empty())
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
