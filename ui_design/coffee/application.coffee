$(document).ready ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit").uniform()

  $("#sidebar a.create-new-organ").click () ->
    $("#create-new-organ").fadeIn('fast')
    return false

  $("#create-new-organ a.close-modal").click () ->
    $("#create-new-organ").fadeOut('fast')
    return false

  $("#single-organ a.application-call").click () ->
    $("#call-for-application").fadeIn('fast')
    return false

  $("#call-for-application a.close-modal").click () ->
    $("#call-for-application").fadeOut('fast')
    return false
