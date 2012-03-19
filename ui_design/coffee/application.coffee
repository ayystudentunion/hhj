loadGreetings = () ->
  $.get("/api/greetings", (data) ->
    greetings = _(data).map(
      (g) -> "<li>#{g.text}</li>"
    ).join("")
    $("#greetings").html(greetings)
  )

jQuery ->
  $("#create_greeting").submit (event) ->
    $.post(
      "/api/greetings",
      $(this).serialize(),
      (data) -> loadGreetings()
    )
    false
  loadGreetings()
