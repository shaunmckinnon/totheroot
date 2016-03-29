$ ->
  $('#etsy_products_search').autocomplete(
    minLength: 0
    source: '/'
    focus: (event, ui) ->
      $('#etsy_products_search').val ui.item.title
      false
    select: (event, ui) ->
      $('#etsy_products_search').val ui.item.title
      getProductModal ui.item
      false
  ).autocomplete('instance')._renderItem = (ul, item) ->
    $('<li>')
      .attr({'title': item.description, 'data-toggle': 'tooltip', 'data-thumbnail': item.images[0], 'data-etsy-url': item.url})
      .append(item.title).appendTo ul

  $(document).on 'click', '[data-toggle="tooltip"]', () ->
    product = $(this)
    getProductModal product

  $('#goGetIt').click () ->
    href = $('#etsy_products_search').attr('data-url')
    if href
      redirectIt href

  getProductModal = (obj) ->
    console.log obj
    $('#product-preview').find('.modal-title').text obj.title
    $('#product-preview').find('.modal-body > p').text obj.description
    $('#product-preview').find('#product-image').attr 'src', obj.images[0]
    $('#product-preview').find('#product-image').attr 'alt', (obj.title + ": " + obj.description)
    $('#product-preview').modal()

    $('#buyItNow').click () ->
      redirectIt obj.url
    return

  redirectIt = (url) ->
    window.open url, '_blank'