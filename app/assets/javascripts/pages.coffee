window.initMap = ->
  uluru = 
    lat: 44.59919
    lng: -79.3613953

  map = new (google.maps.Map)(document.getElementById('google-map'),
    zoom: 17
    center: uluru)

  marker = new (google.maps.Marker)(
    position: uluru
    map: map)

  return