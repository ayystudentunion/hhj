# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

openNewOrganDialog = ->
  $("#create-new-organ").fadeIn('fast')

closeNewOrganDialog = ->
  $("#create-new-organ").fadeOut('fast')

index = ->

newOrgan = ->
  openNewOrganDialog()

$(document).ready ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit").uniform()

  $("#sidebar a.create-new-organ").click () ->
    $("#modal-wrap").show()
    router.setRoute '/organ/new'
    return false

  $("#create-new-organ a.close-modal").click () ->
     $("#modal-wrap").hide()
    router.setRoute '/'
    return false

  $("#single-organ a.application-call").click () ->
    $("#modal-wrap").show()
    $("#call-for-application").fadeIn('fast')
    return false

  $("#call-for-application a.close-modal").click () ->
    $("#modal-wrap").hide()
    $("#call-for-application").fadeOut('fast')
    return false

  $("#single-organ .member-card").click () ->
    $("#modal-wrap").show()
    $("#received-application").fadeIn('fast')
    return false

  $("#received-application a.close-modal").click () ->
    $("#modal-wrap").hide()
    $("#received-application").fadeOut('fast')
    return false

  $('.tab-content').each ->
    $(this).children(':gt(0)').hide()

  $('.tabs-list li a').click ->
    tab = $(this).parents('.tabs').siblings('.tab-content').children('.tab').eq($(this).parent().index())
    if tab.length > 0
      tab.show().siblings().hide()
      $(this).parent().addClass('active').siblings().removeClass 'active'
      tab.trigger('tabActivated')
    false


  router = Router(
    "" : index
    "/organ/new" :
      on:    newOrgan
      after: closeNewOrganDialog
  )

  router.init()
