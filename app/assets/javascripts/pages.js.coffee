# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit").uniform()

  $("#sidebar a.create-new-organ").click () ->
    $("#create-new-organ").fadeIn('fast')
    return false

  $("#create-new-organ a.close-modal").click () ->
    $("#create-new-organ").fadeOut('fast')
    return false
