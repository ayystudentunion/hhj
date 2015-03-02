
loadFragment = (locale, university, controller, param, modal) ->
  controller ?= ""
  param      ?= ""
  getParams  = null

  url = "/#{locale}/#{university}"
  if controller
    url += "/#{controller}"
    if param
      rest = param.split('?')
      getParams = rest[1]
      url += "/#{rest[0]}"
  url += ".fragment"
  if getParams
    url += "?#{getParams}"

  contentWrap = $('#page-content')
  cached.getDOM url, (error, dom) ->
    initDom dom.clone().appendTo(contentWrap.empty())
  return true

testEnvironment = () -> $('body').attr('data-env') == 'test'

init_routing = () ->
  return  if not History.enabled or testEnvironment()
  crossroads.addRoute "/{locale}/{university}/:controller:/:param:", loadFragment
  # crossroads.routed.add(console.log, console);

  $('a').on 'click', (ev) ->
    $this = $(this)
    href = $this.attr 'href'
    return false if $this.hasClass 'js-modal' or href == "#"
    if href.indexOf('http://') == 0 or $this.hasClass("js-reload")
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
