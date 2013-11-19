jQuery ->
  object = $('input:text:visible:first')
  if object
    object = $(object)
    object.focus()
    object.val(object.val())