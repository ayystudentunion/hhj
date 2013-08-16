jQuery ->

  container_class = ".checkboxes_with_limited_selectable"

  $('#modal-wrap').on "click", "#{container_class} input[type=checkbox]", ()->
    container =  $(this).parents(container_class)
    max = container.data('maxLimit')
    return if !max
    max_members_checked =container.find("input[type=checkbox]:checked").length >= Number(max)
    container.find('input[type=checkbox]').not(":checked").attr "disabled", max_members_checked
    message = container.data('errorMessage')
    if max_members_checked && !!message
      $.gritter.add
        title: " "
        text: message
        time: 2000
        class_name: "success"


