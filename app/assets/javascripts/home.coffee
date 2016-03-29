$ ->
  $('#etsy_products_search').autocomplete(
    minLength: 0
    source: '/'
    focus: (event, ui) ->
      $('#etsy_products_search').val ui.item.title
      false
    select: (event, ui) ->
      $('#etsy_products_search').val ui.item.title
      $('#etsy_products_search-description').html ui.item.description
      false
  ).autocomplete('instance')._renderItem = (ul, item) ->
    $('<li>')
      .attr({'title': item.description, 'data-toggle': 'tooltip', 'data-thumbnail': item.images[0], 'data-etsy-url': item.url})
      .append(item.title).appendTo ul

  $(document).on 'click', '[data-toggle="tooltip"]', () ->
    product = $(this)
    $('#product-preview').find('.modal-title').text(product.text())
    $('#product-preview').find('.modal-body > p').text(product.attr('title'))
    $('#product-preview').find('#product-image').attr('src', product.attr('data-thumbnail'))
    $('#product-preview').modal()
  
    $('#buyItNow').click () ->
      $(location).attr('href', product.attr('data-etsy-url'))

  $.ajax(
    url: '/'
    method: 'GET'
    dataType: 'JSON'
    data: term: 'woven').done (data) ->
      console.log data
      return