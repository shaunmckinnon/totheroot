# $ ->
#   headerHomeScrollTop = $('#header-home').offset().top
#   homeFooterScrollTop = $('#home-footer').offset().top

#   console.log headerHomeScrollTop, homeFooterScrollTop

#   $(window).scroll () ->
#     limit = $(document).scrollTop()
#     if limit > headerHomeScrollTop + 200
#       console.log 'home', limit, homeFooterScrollTop
#       $('html, body').animate { scrollTop: $('#home-footer').offset().top }
      # return