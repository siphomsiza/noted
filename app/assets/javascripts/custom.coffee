jQuery ->
  $(document).on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $(document).on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  #activate schedule tabs
  hash = window.location.hash
  hash and $('ul.nav a[href="' + hash + '"]').tab('show')

  #make menus drop automatically
  $('ul.nav li.dropdown').hover (->
    $('.dropdown-menu', this).fadeIn()
    return
    ), ->
    $('.dropdown-menu', this).fadeOut 'fast'
    return
