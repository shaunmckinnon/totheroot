$ ->
  if $('#autocomplete-search')
    $('#autocomplete-search').autocomplete(
      minLength: 0
      source: '/autocomplete'
      focus: (event, ui) ->
        $('#autocomplete-search').val ui.item.title
        false
      select: (event, ui) ->
        $('#autocomplete-search').val ui.item.title
        false
    ).autocomplete('instance')._renderItem = (ul, item) ->
      $('<li>')
        .attr({'title': item.description, 'data-toggle': 'tooltip', 'data-thumbnail': item.images[0], 'data-etsy-url': item.url})
        .append(item.title).appendTo ul