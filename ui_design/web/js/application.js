(function() {
  var loadGreetings;

  loadGreetings = function() {
    return $.get("/api/greetings", function(data) {
      var greetings;
      greetings = _(data).map(function(g) {
        return "<li>" + g.text + "</li>";
      }).join("");
      return $("#greetings").html(greetings);
    });
  };

  jQuery(function() {
    $("#create_greeting").submit(function(event) {
      $.post("/api/greetings", $(this).serialize(), function(data) {
        return loadGreetings();
      });
      return false;
    });
    return loadGreetings();
  });

}).call(this);
