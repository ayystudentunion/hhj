# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

initLanguageSelectors = () ->
  $('.language-sel a').click ->
    window.location = window.location.pathname + "?locale=#{$(this).attr 'hreflang'}"
    return false

$(document).ready ->
  initLanguageSelectors()
  initDom('body')

