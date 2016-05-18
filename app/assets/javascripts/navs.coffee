$ ->
  $('#sign-in-link').on 'click', (e) ->
    e.preventDefault()
    $('#sign-in').modal 'show'
    return