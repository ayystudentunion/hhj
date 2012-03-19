
  $(document).ready(function() {
    $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit").uniform();
    $("#sidebar a.create-new-organ").click(function() {
      $("#create-new-organ").fadeIn('fast');
      return false;
    });
    return $("#create-new-organ a.close-modal").click(function() {
      $("#create-new-organ").fadeOut('fast');
      return false;
    });
  });
