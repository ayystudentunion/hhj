
  $(document).ready(function() {
    $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit").uniform();
    $("#sidebar a.create-new-organ").click(function() {
      $("#create-new-organ").fadeIn('fast');
      return false;
    });
    $("#create-new-organ a.close-modal").click(function() {
      $("#create-new-organ").fadeOut('fast');
      return false;
    });
    $("#single-organ a.application-call").click(function() {
      $("#call-for-application").fadeIn('fast');
      return false;
    });
    return $("#call-for-application a.close-modal").click(function() {
      $("#call-for-application").fadeOut('fast');
      return false;
    });
  });
